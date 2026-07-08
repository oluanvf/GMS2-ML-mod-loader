varying vec2 v_vTexcoord;
varying vec4 v_vColour;

int maxCodeSize = 300;

//extern
uniform float FshCode[300];	 
uniform float FshVarsU[100]; 

float	FshVars[100];
int		line = 0;
vec2	self;
int		inScript = -1;
vec4	scripts[8]; //linha, returned, returnVal, type
vec4	vetores[8];


vec2 getVal(){
	if(int(FshCode[line])==-1)
	{
		return self;
	}else
	if(int(FshCode[line])==-2)
	{
		line+=1;
		int _path = int(FshCode[line]);
		return vec2(FshVars[_path], _path);
	}
	return vec2(FshCode[line], FshCode[line]);
}

vec2 getIn(){
	if(int(FshCode[line])==-3)
	{
		line+=1;
		vec2 _var = getVal();
		line+=1;
		vec2 _index = getVal();
		int _path = int(_var.y+_index.y);
		return vec2(FshVars[_path], float(_path));
	}
	return getVal();
}

vec2 get(){
	if(int(FshCode[line])==-4)//-
	{
		line+=1;
		vec2 _var = getIn();
		_var.x*=-1.0;
		return _var;
	}else
	if(int(FshCode[line])==-25)//not !
	{
		line+=1;
		vec2 _var = getIn();
		return vec2(float(!bool(_var.x)), _var.y);
	}
	return getIn();
}

int goToEnd(){
	int ended = 0;
	while(ended>=0){
		line+=1;
		if(line==maxCodeSize){break;}
		if(FshCode[line]==-200.0){break;}
		if(FshCode[line]==-16.0||FshCode[line]==-15.0)
		{
			ended+=1;
		}
		if(int(FshCode[line])==-18)
		{
			ended-=1;
		}
		if(ended<0){break;}
		
	}
	
	return 1;
}


void main()
{
    vec4 color	= v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	FshVars[0]	= color.r;
	FshVars[1]	= color.g;
	FshVars[2]	= color.b;
	FshVars[3]	= color.a;
	FshVars[4]	= v_vTexcoord.x;
	FshVars[5]	= v_vTexcoord.y;
	
	
	for(int i = 0; i < 100; i+=2)
	{
		if(FshVarsU[i]==-200.0){break;}
		int _pos = int(FshVarsU[i]);
		FshVars[_pos]=FshVarsU[i+1];
	}
	
	for(line=0; line < maxCodeSize; line++)
	{
		if(FshCode[line]==-200.0){break;}
		int c = int(FshCode[line]);	
		
		if(c==-5)//mov
		{
			line+=1;
			self = get();
			line+=1;
			vec2 _val = get();
			FshVars[int(self.y)]=_val.x;
		}else
		if(c==-6)//add
		{
			line+=1;
			self = get();
			line+=1;
			vec2 _val = get();
			FshVars[int(self.y)]+=_val.x;
		}else
		if(c==-7)//sub
		{
			line+=1;
			self = get();
			line+=1;
			vec2 _val = get();
			FshVars[int(self.y)]-=_val.x;
		}else
		if(c==-8)//mul
		{
			line+=1;
			self = get();
			line+=1;
			vec2 _val = get();
			FshVars[int(self.y)]*=_val.x;
		}else
		if(c==-9)//div
		{
			line+=1;
			self = get();
			line+=1;
			vec2 _val = get();
			FshVars[int(self.y)]/=_val.x;
		}else
		if(c==-10)//and
		{
			line+=1;
			self = get();
			line+=1;
			vec2 _val = get();
			line+=1;
			vec2 _val2 = get();
			FshVars[int(self.y)]=float(bool(_val.x)&&bool(_val2.x));
		}else
		if(c==-11)//or
		{
			line+=1;
			self = get();
			line+=1;
			vec2 _val = get();
			line+=1;
			vec2 _val2 = get();
			FshVars[int(self.y)]=float(bool(_val.x)||bool(_val2.x));
		}else
		if(c==-12)//xor
		{
			line+=1;
			self = get();
			line+=1;
			vec2 _val = get();
			line+=1;
			vec2 _val2 = get();
			FshVars[int(self.y)]=float(bool(_val.x)!=bool(_val2.x));
		}else
		if(c==-13)//not
		{
			line+=1;
			self = get();
			line+=1;
			vec2 _val = get();
			FshVars[int(self.y)]=float(!bool(_val.x));
		}else
		if(c==-14)//cmp
		{
			line+=1;
			self = get();
			line+=1;
			vec2 _val = get();
			line+=1;
			vec2 _val2 = get();
			FshVars[int(self.y)]=float(_val.x==_val2.x);
		}else
		if(c==-15)//if se
		{
			line+=1;
			if(!bool(get().x))
			{
				goToEnd();
			}else
			{
				inScript += 1;
				scripts[inScript] = vec4(0.0,0.0,0.0,-1.0);
			}
		}else
		if(c==-16)//func
		{
			line+=1;
			vec2 function = get();
			FshVars[int(function.y)]=float(line);
			goToEnd();
		}else
		if(c==-18)//end
		{
			if(inScript>=0)
			{
				if(scripts[inScript].a==-1.0){ //if
					inScript-=1;
				}else
				if(scripts[inScript].a==-2.0)
				{
					scripts[inScript].g	 =	1.0;
					line=int(scripts[inScript].r);
				}
			}
			
		}else
		if(c==-19)//call
		{
			int myLine = line-1;
			line+=1;
			vec2 path = get();
			line+=1;
			vec2 function = get();
			bool MakeCall = true;
			
			
			if(inScript>=0)
			{
				//ja retornou
				if(bool(scripts[inScript].g))
				{
					//puxar resultado
					FshVars[int(path.y)] = scripts[inScript].b;
					scripts[inScript].g	 = 0.0;
					MakeCall			 = false;
					inScript			-= 1;
				}
			}
			if(MakeCall)
			{
				inScript		 += 1;
				scripts[inScript] = vec4(myLine,0.0,-4,-2.0);
				line			  = int(function.x);
			}
			
		}else
		if(c==-26)//run
		{
			int myLine = line-1;
			line+=1;
			vec2 function = get();
			bool MakeCall = true;
			
			if(inScript>=0)
			{
				//ja retornou
				if(bool(scripts[inScript].g))
				{
					scripts[inScript].g	 = 0.0;
					MakeCall			 = false;
					inScript			-= 1;
				}
			}
			if(MakeCall)
			{
				inScript		 += 1;
				scripts[inScript] = vec4(myLine,0.0,-4,-2.0);
				line			  = int(function.x);
			}
		}else
		if(c==-20)//vec 2
		{
			line+=1;
			self = get(); //path
			line+=1;
			vec2 _val = get(); //x
			line+=1;
			vec2 _val2 = get(); //y
			vec4 selfV = vetores[int(self.x)];
			vetores[int(self.x)]=vec4(_val.x, _val2.x, selfV.b, selfV.a);
		}else
		if(c==-23)//texture2d
		{
			line+=1;
			self = get(); //path
			line+=1;
			vec2 _val = get(); //vector id
			vec4 _result = texture2D(gm_BaseTexture, vetores[int(_val.x)].xy);
			FshVars[int(self.y)]=_result.r;
			FshVars[int(self.y+1.0)]=_result.g;
			FshVars[int(self.y+2.0)]=_result.b;
			FshVars[int(self.y+3.0)]=_result.a;
		}else
		if(c==-24)//ret
		{
			line+=1;
			vec2 _val = get(); //x
			if(inScript>=0)
			{
				scripts[inScript].b = _val.x;
				scripts[inScript].g	 =	1.0;
				line=int(scripts[inScript].r);
			}
		}
		
	}
	
	gl_FragColor = vec4(FshVars[0], FshVars[1], FshVars[2], FshVars[3]);
}
