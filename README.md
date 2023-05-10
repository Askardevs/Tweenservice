```lua
--[[
█████╗ ███████╗██╗  ██╗ █████╗ ██████╗ ██████╗     ██████╗ ███████╗██╗   ██╗███████╗██╗      ██████╗ ██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██║ ██╔╝██╔══██╗██╔══██╗██╔══██╗    ██╔══██╗██╔════╝██║   ██║██╔════╝██║     ██╔═══██╗██╔══██╗██╔════╝██╔══██╗
███████║███████╗█████╔╝ ███████║██████╔╝██║  ██║    ██║  ██║█████╗  ██║   ██║█████╗  ██║     ██║   ██║██████╔╝█████╗  ██████╔╝
██╔══██║╚════██║██╔═██╗ ██╔══██║██╔══██╗██║  ██║    ██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║     ██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗
██║  ██║███████║██║  ██╗██║  ██║██║  ██║██████╔╝    ██████╔╝███████╗ ╚████╔╝ ███████╗███████╗╚██████╔╝██║     ███████╗██║  ██║
]]--Sistema Bomba 1.0
```

# Lua tweenservice library

## Introduction

This is a simple library to create animations making InterpolateBetween easier to use and you can make edits without limitations, just be careful how you call it.

## Installation

Just download file `tween-service.lua` and put it in your project directory. it will work in any project that uses Lua.

* Note: This library he was created and tested on Lua 5.1

## Creating Meta File

```xml
<meta>
    <oop>true</oop>
    <info author='Askard' version='1.0' description='TweenService System' />

    <script src='tween-service.lua' type='client' cache='false' />
</meta>
```

## Creating TweenService

Create a new tweenservice using the method `new`, the method takes a table with the following properties: startValue, endValue, duration, easing Type. For example:

```lua
local TweenService = TweenService.new()
```

## Instantiating

You can start it either outside **OnClientClick** or inside using the `new` method to instantiate it. For Example:

```lua
TweenService:setup(0, 500, 5000, 'InOutQuad')
```

## GetTweenValue

The simplest way to get the current **Tween** value is this way, but you can do it in others and adapt it to your liking as this is a code to educate and teach beginners.

```lua

Animations = {
    example = 0;
}

function TweenService:setOnUpdate(callback)
    self.onUpdate = callback
end

TweenService:setOnUpdate(function(value)
    Animations.example = value
end)
```

## Render Example

This is basically the way you should use the `TweenService`, never put it inside the Render it will create an infinite **loop** and that's not what we want.

```lua
function TweenService:draw()
    dxDrawRectangle(0, Animations.example, 100, 100, tocolor(255, 255, 255))
end

function TweenService:addEventHandlers()
    addEventHandler( 'onClientRender', root, function() self:draw() end)
end

TweenService:addEventHandlers()
```


### Method onClientClick

This is an example of how to use the library with `onClientClick` to set values on click and expand your way of using **TweenService**, first we will start by creating a function that we can use to check the clicked location on the screen and we will also add a table with the position of clicks. For Example:

```lua
Animations = {
    down = {0, 0}
}

function TweenService:setOnUpdate(callback)
    self.onUpdate = callback
end

TweenService:setOnUpdate(function(value)
    Animations.down[1] = value
end)

function TweenService:setEndValue(callback)
    self.onComplete = callback
end

TweenService:setEndValue(function(value)
    Animations.down[2] = value
end)

function TweenService:draw()
    dxDrawRectangle(0, Animations.down[1], 100, 100, tocolor(255, 255, 255))
end

function TweenService:onMouseClick ( button, state, absoluteX, absoluteY )
    if (button == 'left' and state == 'down') then
        if Animations.down[2] ~= absoluteY then
            TweenService:setup(Animations.down[1], absoluteY, 5000, 'InOutQuad')
        end
    end
end
```

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/Askardevs/Tweenservice/blob/main/LICENSE) file for details
