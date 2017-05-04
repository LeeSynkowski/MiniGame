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

local touchTracker = {}


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
 
    --print( "Touched Start Rectangle" )
    if (table.getn(touchTracker) == 0 ) then
      table.insert(touchTracker,1)
    end
    --return true
end

-- finishRectangle Touch event listener
local function finishRectangleTouchListener( event )
 
    --print( "Touched Finish Rectangle" )
    if (table.getn(touchTracker) == 1 ) then
      table.insert(touchTracker,2)
    end
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
    --local canvas = fingerPaint.newCanvas()
    --canvas.setCanvasColor(0,0,0,0)
    --canvas.setPaintColor(205/255,75/255,244/255,1)
    --sceneGroup:insert( canvas )
    
    -- Create start and finish rectangles with their own touch listeners
    local rect1x = math.random(display.actualContentWidth-20)
    local rect2x = math.random(display.actualContentWidth-20)    
    local rect1y = math.random(display.contentCenterY-20)
    local rect2y = math.random(display.contentCenterY,display.actualContentHeight-30)      
    
    --rectangle
    --local startRectangle = display.newRect( display.contentCenterX, display.contentCenterY + display.actualContentHeight/4, 20, 20 )
    local startRectangle = display.newRect( rect1x, rect1y, 20, 20 )
    startRectangle:setFillColor( 0, 1, 0 )
    startRectangle:addEventListener( "touch", startRectangleTouchListener)
    sceneGroup:insert( startRectangle )
    --label
    local label1 = display.newText("1", rect1x, rect1y, 20, 20 )
    label1:setFillColor( 0, 0, 0 )
    sceneGroup:insert( label1 )    
    
    --local finishRectangle = display.newRect( display.contentCenterX, display.contentCenterY - display.actualContentHeight/4, 20, 20,native.systemFont, 20 )
    
    local finishRectangle = display.newRect( rect2x, rect2y, 20, 20,native.systemFont, 20 )    
    finishRectangle:setFillColor( 1, 0, 0 )
    finishRectangle:addEventListener( "touch", finishRectangleTouchListener)
    sceneGroup:insert( finishRectangle ) 
    
    local label2 = display.newText("2", rect2x, rect2y, 20, 20 )
    label1:setFillColor( 0, 0, 0 )
    sceneGroup:insert( label2 )   
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