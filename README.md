# Applying Textures In OpenGL ES

##Introduction

Now that you know [how to render a character using OpenGL ES][1], you may want to learn how to apply images (textures) to a character. The process of applying a texture to a character is quite simple. We simply load texture coordinates into OpenGL buffers, along with the raw image representing the texture. 

###Objective
Our objective is to learn how to apply a texture to a character as seen in the image below. 

![Textures in iOS devices](https://dl.dropboxusercontent.com/u/107789379/CGDemy/blogimages/textureiniOSDevice.png)

This is a continuation tutorial from our previous tutorial, [How to render a character in iOS devices][1]. 

This tutorial is a hands-on project. Feel free to download this template [XCode project][2] and code along.  

[2]: https://dl.dropboxusercontent.com/u/107789379/haroldserrano/MakeOpenGLProject/Applying%20textures%20to%20Game%20Characters/Template-Skeleton.zip


###Things to know
If this is your first time reading about textures in computer graphics, I recommend you read: 

* [How textures are applied to characters][3]
* [How to render a character in iOS devices][1]
* [What is a shader?][4]

[4]: http://www.haroldserrano.com/blog/what-is-a-shader-in-computer-graphics
[3]: http://www.haroldserrano.com/blog/how-textures-are-applied-to-characters
[1]: http://www.haroldserrano.com/blog/how-to-render-a-character-in-ios-devices

##What is a Texture?
A texture is simply an image that *clothes* a character. Figure 1 shows a 3D model without texture and with texture. You can see that a texture adds personality to the model.

#####Figure 1. A model with and without texture.

![what is a texture](https://dl.dropboxusercontent.com/u/107789379/CGDemy/blogimages/whatisTextureExample.png)

##What is a UV Map?
Let's assume that you, aside from being a game developer, are also a 3D modeler. You decide to model a nice looking robot on *Blender*, a 3D modeling software. Your intentions are to apply a texture to the robot, therefore, you unwrap the model to its 2D equivalent, as shown below. 

#####Figure 2. Unwrapping a 3D model
![unwrapping of model](https://dl.dropboxusercontent.com/u/107789379/CGDemy/blogimages/cgdemycharacteruvmap.png)

By unwrapping the 3D character into a 2D entity, an image can properly be glued to the character. The process of *unwrapping* a 3D model into its 2D equivalent produces what is known as a **UV Map**. Figure 2 shows an example of a *UV Map*.

The process does not stop there. The *UV Map* is usually exported to an application like *Photoshop* or *GIMP*, where it is used as a blueprint to paint over a blank canvas. The resulting artwork is then saved as a .png file and imported back into *Blender* where you could see the final result. The resulting .png file, i.e., an image, is known as a **Texture**.

#####Figure 3. UV Map with image

![uv map with image](https://dl.dropboxusercontent.com/u/107789379/CGDemy/blogimages/cgdemymascotuvmapwithimage.png)

##What are UV Coordinates?
During the unwrapping process, the vertices of the 3D model are mapped into a two-dimensional coordinate system. This new coordinate system is known as the **UV Coordinate System**.

The *UV Coordinate System* is composed of two axes, known as *U* and *V* axes. These axes are equivalent to the *X-Y* axes you are familiar with. The only difference is that the *U-V* axes ranges from 0 to 1.

The new vertices produced by the unwrapping of the model are called **UV Coordinates**. These coordinates will be loaded into the GPU. And will serve as reference points to the GPU as it attaches the texture to the model.

##Loading UV Coordinates
The loading of *UV Coordinates* into an OpenGL buffer is exactly similar as the loading of *vertex* data. We will use the same loading method employed in our previous tutorial: [How to render a character in iOS][1].

###Increase the size of the buffer
Since we are going to add *UV* coordinate data into the buffer, we need to allocate additional space to the buffer. The additional space required depends on the size of our *robot_uv* array. 

>The *robot_uv* array is found in the Robot.h file.

Open up file Character.mm. Locate the *setupOpenGL()* method. Go to line *5* and modify *glBufferData()* from what is shown in listing 1:

#####Listing 1 Previous glBufferData.
<pre>
<code class="language-c">
void Character::setupOpenGL(){
//...Binded VAO and Buffers

//5. Dump data into the buffer

glBufferData(GL_ARRAY_BUFFER, sizeof(robot_vertices)+sizeof(robot_normal), NULL, GL_STATIC_DRAW);

//...loaded data using glBufferSubData

}
</code>
</pre>

to what is shown in listing 2.

#####Listing 2 Modified glBufferData.
<pre>
<code class="language-c">
void Character::setupOpenGL(){
//...Binded VAO and Buffers

//5. Dump data into the buffer

glBufferData(GL_ARRAY_BUFFER, sizeof(robot_vertices)+sizeof(robot_normal)+sizeof(robot_uv), NULL, GL_STATIC_DRAW);

//...loaded data using glBufferSubData

}
</code>
</pre>

###Load UV Coordinates
Now that we have allocated enough memory in the buffer, we can load the *UV* coordinates data. In the *setupOpenGL* method, go to line *5c* and load the *UV* data as shown in listing 3.

#####Listing 3.
<pre>
<code class="language-c">

//5c. Load UV coordinates with glBufferSubData
    
glBufferSubData(GL_ARRAY_BUFFER, sizeof(robot_vertices)+sizeof(robot_normal), sizeof(robot_uv), robot_uv);
    
</code>
</pre>

###Get Location of the texture attribute
Next, we need to find the location of the attribute *texCoord* in the shader. We will use this location to link the *UV* coordinate data in the buffer to the *texCoord* [attribute][5].

[5]: http://www.cgdemy.com/blog/what-is-a-shader-in-computer-graphics

Go to line *8* and type what is shown in listing 4.

#####Listing 4.
<pre>
<code class="language-c">

//8. Get the location of the shader attribute called "texCoords"
    
uvLocation=glGetAttribLocation(programObject, "texCoord");
    
</code>
</pre>

###Enable the UV attribute
Next, we need to enable the *UV* [attributes][6]. That is, make the attribute available to accept data coming from the buffer.

[6]: http://www.haroldserrano.com/blog/what-is-a-shader-in-computer-graphics

Go to line *9c* and type what is shown in listing 5.

#####Listing 5.
<pre>
<code class="language-c">

//9c. Enable the UV attribute
glEnableVertexAttribArray(uvLocation);
    
</code>
</pre>

###Link UV data to attribute location
Next, we are going to link the *UV* coordinate data in the buffer to the *texCoord* attribute location.

Go to line 10c and type what is shown in listing 6.

#####Listing 6.
<pre>
<code class="language-c">

//10c. Link the buffer data to the shader's UV location
glVertexAttribPointer(uvLocation, 2, GL_FLOAT, GL_FALSE, 0, (const GLvoid*)(sizeof(robot_vertices)+sizeof(robot_normal)));
    
</code>
</pre>


##Creating Texture Objects
Before we create an OpenGL Object designed to deal with textures, OpenGL requires the activation of a **Texture-Unit**. A *texture-unit* is the section in the GPU responsible for **Texturing Operations**. 

>After activating a texture-unit, any subsequent operation affects that particular texture-unit. Thus, subsequent creation of an OpenGL Object, makes the texture-unit the owner of the object.

Our first task is to activate a texture-unit, then create and bind an OpenGL Texture Object. 

OpenGL objects designed to work with textures are called **Texture Objects**. Like any other OpenGL Object, *Texture Objects* require its behavior to be specified. 

*Texture Objects* can either behave as objects that carry *two-dimensional images* or *Cube Maps images*. Cube Maps images are a collection of six 2D-images that form a cube; they are used to provide a *sky scenery* in a game. 

Let's create a texture unit and a Texture Object. Locate the method  *setupOpenGL()*  and copy what is shown in listing 7.

A *texture-unit* is activated as shown in line 14. The generation and binding of a texture object as shown in line 15 & 16. In this example, we are defining the behavior of the texture object as a *two-dimensional image*.

#####Listing 7. Creating a Texture OpenGL Object
<pre>
<code class="language-c">

//14. Activate GL_TEXTURE0
glActiveTexture(GL_TEXTURE0);

//15.a Generate a texture OpenGL object
glGenTextures(1, &textureID[0]);

//16 Bind the texture OpenGL object. Any subsequent OpenGL operations, will apply to this object.
glBindTexture(GL_TEXTURE_2D, textureID[0]);

</code>
</pre>

##Loading the image into a Texture Object
###Decompressing the image
Texture images are normally exported in .png, .tga or .jpeg formats. Unfortunately, these image-compression formats are not accepted by OpenGL. Images must be decompressed to a *raw-format* before they can be loaded into a texture object. The OpenGL API does not provide any decompression utility. 

Fortunatelly, there exist various libraries which can be integrated in your application. One of them is called [Lodepng][7]. This library accepts a *.png* image and provides a decompressed version of the image.

[7]: http://lodev.org/lodepng/

In the *setupOpenGL()* method, type what is shown in listing 8. The method *convertImageToRawImage()* is a helper method, which calls a decompression method in the *lodepng* library. In the example below, we provide the name of our texture, in this case, *red.png* (line 17).

#####Listing 8. Converting images to raw data
<pre>
<code class="language-c">
//17. Decode image into its raw image data
if(convertImageToRawImage("red.png")){

//if decompression was successful, set the texture parameters

}
</code>
</pre>

###Setting Texture Parameters
If the decompression of the image is successful, **Texture Parameters** can be set. *Texture Parameters* inform the GPU how to apply the texture to the 3D model. That is, *should it magnify or minimize the texture?* We are going to ask OpenGL to clamp our image to the edges of our model and to do a linear interpolation between the pixels and texels.

In method *setupOpenGL()*. Type what is shown in lines 17a & 17b in listing 9. 

#####Listing 9. Setting the texture parameters.

<pre>
<code class="language-c">

//17a. set the texture wrapping parameters
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

//17b. set the texture magnification/minification parameters
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,GL_LINEAR);
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

</code>
</pre>

#####Texture Filtering
The geometry of a model usually does not have a one-to-one correspondence with the texture. The texture will need to be streched or shrunk to make it fit the model. To provide a better fit calculation between the model and the image, OpenGL provides settings for its *magnification* (stretch) and *minification* (shrink) filters.

Each of these filters can behave as a *Nearest* or a *Linear* Filter.

As a *Nearest* filter, the texture coordinates will have a one-to-one correspondence with the texels (the texture-based equivalent of pixels) in the texture map. Whichever texel the coordinate falls in, that color is used for the fragment texture color.

A *linear* filter however, does not work by taking the nearest pixel, but by applying a weighted average of the texels surrounding the texture coordinate.

#####Texture Wrapping
*UV* coordinates fall between the range of \[0,1\]. However, if *UV* coordinates fall outside this range, OpenGL handles the coordinates according to the texture wrapping mode. These modes can either be set to Repeat, Clamp, Clamp to edge or Clamp to border.

###Loading the image
Finally, we are now able to load the image into the currently bound *Texture Object*. The loading of the image is done through the OpenGL function *glTexImage()*. This function requires the raw-image data, height and width of the image. These set of data were produced by the *lodepng* utility. See method *convertImageToRawImage()* in *Character.mm*.

In method *setupOpenGL()*, go to line 17c and type what is shown in listing 10.

#####Listing 10. Loading image to the texture buffer
<pre>
<code class="language-c">

//17c. load the image data into the current bound texture buffer
glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, imageWidth, imageHeight, 0,
GL_RGBA, GL_UNSIGNED_BYTE, &image[0]);

</code>
</pre>

###Obtaining the location of the Uniform 2DSampler
I have not talked about [shaders][8] in depth. I will introduce you to shaders in the next couple of posts. *Shaders* is a complicated subject and talking about it here may add confusion. For now, absorb how *textures* are setup and applied to characters on the OpenGL client-side.

[8]: http://www.haroldserrano.com/blog/what-is-a-shader-in-computer-graphics

Nonetheless, I'm force to talk a bit about shaders and textures. In simple terms, a **2DSampler** is a *Uniform* variable which contains a link to the image loaded using the function *glTexImage* (see listing 10). 

In order to properly address the *2DSampler* during rendering, we need to know its location. Our *2DSampler* is called *TextureMap*. (Open the  *Shader.fsh* file if curious to see this Uniform)

We are going to get the location of the 2DSampler by typing what is shown in listing 11. Go to line 18 in the method *setupOpenGL* and type the following:

#####Listing 11. Getting the location of the 2DSampler
<pre>
<code class="language-c">
//18. Get the location of the Uniform Sampler2D
UVMapUniformLocation=glGetUniformLocation(programObject, "TextureMap");
</code>
</pre>

We will use this location in our rendering loop.

##Applying the texture to the character
Finally, we are able to apply the texture to the character. This will be done during our rendering loop. 

We first activate our *texture-unit 0*. Once activated, we can bind our texture object. Finally, we link the image in the *texture object* to the *Sampler2D* in the shader. 

>If you recall, we obtained the location of the Sampler2D *TextureMap* in listing 11.

Open up file *Character.mm* and go to method *Draw()*. Type lines 3-5 as shown in listing 12.

#####Listing 12. Applying the texture to the character
<pre>
<code class="language-c">

//3. Activate the texture unit
glActiveTexture(GL_TEXTURE0);

//4 Bind the texture object
glBindTexture(GL_TEXTURE_2D, textureID[0]);

//5. Specify the value of the UV Map uniform
glUniform1i(UVMapUniformLocation, 0);

</code>
</pre>

##Final Result
Run the project. You should now see the robot with its new image apply to it.

#####Figure 4. A 3D model with texture on a iOS device
![Textures in iOS devices](https://dl.dropboxusercontent.com/u/107789379/CGDemy/blogimages/textureiniOSDevice.png)

###Questions?
If you are interested in knowing more about this post, please visit http://www.haroldserrano.com/blog/how-to-apply-textures-to-a-character-in-ios Feel free to contact me with any questions.
