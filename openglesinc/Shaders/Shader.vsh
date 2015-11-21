//
//  Shader.vsh
//  openglesinc
//
//  Created by Harold Serrano on 2/9/15.
//  Copyright (c) 2015 www.roldie.com. All rights reserved.
//

//1. declare attributes
attribute vec4 position;
attribute vec2 texCoord;

//2. declare varying type which will transfer the texture coordinates to the fragment shader
varying mediump vec2 vTexCoordinates;

//3. declare a uniform that contains the model-View-projection matrix
uniform mat4 modelViewProjectionMatrix;

void main()
{
    //4. recall that attributes can't be declared in fragment shaders. Nonetheless, we need the texture coordinates in the fragment shader. So we copy the information of "texCoord" to "vTexCoordinates", a varying type.
    
	vTexCoordinates=texCoord;
	
    //5. transform every position vertex by the model-view-projection matrix
	gl_Position = modelViewProjectionMatrix * position;
}
