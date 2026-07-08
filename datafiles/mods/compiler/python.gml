function ytg_py_init(){return "import ctypes\nctypes.windll.user32.ShowWindow(ctypes.windll.kernel32.GetConsoleWindow(), 2)\n"}


function ytg_py_to_wav(entradaMP3, saidaWAV, ffmpeg){
	ffmpeg=string_replace_all(ffmpeg, @"\", "/")
	saidaWAV=string_replace_all(saidaWAV, @"\", "/")
	entradaMP3=string_replace_all(entradaMP3, @"\", "/")
	return (
@"
import subprocess
import os

# Defina os caminhos
arquivo_mp3 = "    + "\"" + string(entradaMP3)+"\""+@"  # Caminho do arquivo MP3 de entrada
arquivo_ogg ="     + "\"" + string(saidaWAV)+"\""+@"    # Caminho do arquivo OGG de saída
ffmpeg_directory ="+ "\"" + string(ffmpeg)+"\""+@"  # Caminho para o ffmpeg

# Verifica se o arquivo MP3 existe
if not os.path.exists(arquivo_mp3):
    print(f"+"\"Erro: O arquivo {arquivo_mp3} não foi encontrado.\")"+@"
    exit(1)

# Comando para converter MP3 para OGG usando ffmpeg
comando = [ffmpeg_directory, "+"\"-y\",\"-i\", arquivo_mp3, \"-acodec\", \"pcm_s16le\",\"-ac\", \"1\",\"-ar\",\"44100\",arquivo_ogg]"+@"

# Executa o comando
try:
    subprocess.run(comando, check=True)
    print(f"+"\"Conversão concluída! Arquivo salvo em: {arquivo_ogg}\")"+@"
except subprocess.CalledProcessError as e:
    print("+"\"Erro ao converter:\")"+@"
    exit(1)")
}

function ytg_wav_to_buffer(path){
	var buf = buffer_load(path)
	var size = buffer_get_size(buf);

	// Sample rate (offset 24)
	buffer_seek(buf, buffer_seek_start, 24);
	var sample_rate = buffer_read(buf, buffer_u32);
	
	// Canais (offset 22)
	buffer_seek(buf, buffer_seek_start, 22);
	var channels = buffer_read(buf, buffer_u16);

	// Bits por sample (offset 34)
	buffer_seek(buf, buffer_seek_start, 34);
    var bits_per_sample = buffer_read(buf, buffer_u16);

    var buffer_format = buffer_s16
    if(bits_per_sample == 8){buffer_format=buffer_u8}
    
    // Procurar "data" chunk
    var data_offset = -1;
    for (var i = 12; i < size - 4; i++) {
        buffer_seek(buf, buffer_seek_start, i);
        if (buffer_read(buf, buffer_string) == "data") {
            data_offset = (i + 8);
            break;
        }
    }

    if (data_offset == -1) {
        show_debug_message("Erro: chunk 'data' não encontrado");
        buffer_delete(buf);
        return -1;
    }
	
    // Tamanho do bloco de áudio
    buffer_seek(buf, buffer_seek_start, data_offset - 4);
    var data_size = buffer_read(buf, buffer_u32);
	
    // Criar novo buffer só com os dados de áudio puros
    var audio_buf = buffer_create(data_size, buffer_fixed, 1);
    buffer_copy(buf, data_offset, data_size, audio_buf, 0);
    buffer_delete(buf);
	var channel = audio_mono
	if(channels == 2){channel=audio_stereo}
	
	var byte = 1;
	if(buffer_format==buffer_s16){byte=2}
	var ret ={
		buffer : undefined, 
		format : buffer_format,
		rate : sample_rate,
		size : data_size,
		channel : channel,
		byte : byte,
		data : buffer_base64_encode(audio_buf, 0, data_size)
	}
	buffer_delete(audio_buf)
	return ret
}