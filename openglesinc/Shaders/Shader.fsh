//
//  Shader.fsh
//  openglesinc
//
//  Created by Harold Serrano on 2/9/15.
//  Copyright (c) 2015 www.haroldserrano.com. All rights reserved.
//
precision highp float;

//1. declare a uniform sampler2d that contains the texture data
uniform sampler2D TextureMap;

//2. declare varying type which will transfer the texture coordinates from the vertex shader
varying mediump vec2 vTexCoordinates;

void main()
{
    //3. Sample the texture using the Texture map and the texture coordinates
	mediump vec4 color=texture2D(TextureMap,vTexCoordinates.st);
    
    //4. Apply the sample color of the texture to the output of the shader.
	gl_FragColor = color;
    
}