-----------------------------------------------------------------------------------------
--
-- FirstType.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local fingerPaint = require( "fingerPaint" )
 
local scene = composer.newScene()

-- Activate multitouch
system.activate( "multitouch" )
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- Printing touch info Touch event listener
local function touchListener( event )
 
    print( "Phase: " .. event.phase )
    print( "Location: " .. tostring(event.x) .. "," .. tostring(event.y) )
    print( "Unique touch ID: " .. tostring(event.id) )
    print( "----------" )
    --return true
end

-- startRectangle Touch event listener
local function startRectangleTouchListener( event )
 
    print( "Touched Start Rectangle" )
    --return true
end

-- finishRectangle Touch event listener
local function finishRectangleTouchListener( event )
 
    print( "Touched Finish Rectangle" )
    --return true
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    -- Create Background that tracks touches
    local background = display.newRect( display.contentCenterX, display.contentCenterY, 280, 440 )
    background:setFillColor( 0, 0, 0 )
    --Add a touch listener to the object
    --background:addEventListener( "touch", touchListener )
    sceneGroup:insert( background )
    
    -- Use basic fingerPaint canvas to track touches
    local canvas = fingerPaint.newCanvas()
    canvas.setCanvasColor(0,0,0,0)
    canvas.setPaintColor(205/255,75/255,244/255,1)
    sceneGroup:insert( canvas )
    
    -- Create start and finish rectangles with their own touch listeners
    local startRectangle = display.newRect( display.contentCenterX, display.contentCenterY + display.actualContentHeight/4, 20, 20 )
    startRectangle:setFillColor( 0, 1, 0 )
    startRectangle:addEventListener( "touch", startRectangleTouchListener)
    sceneGroup:insert( startRectangle )
    local finishRectangle = display.newRect( display.contentCenterX, display.contentCenterY - display.actualContentHeight/4, 20, 20 )
    finishRectangle:setFillColor( 1, 0, 0 )
    finishRectangle:addEventListener( "touch", finishRectangleTouchListener)
    sceneGroup:insert( finishRectangle )  
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene