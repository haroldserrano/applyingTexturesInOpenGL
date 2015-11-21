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

The *UV Coordinate System* is composed of...
Read more about this tutorial and repository at http://www.haroldserrano.com/blog/how-to-apply-textures-to-a-character-in-ios
