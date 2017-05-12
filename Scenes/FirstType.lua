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
local function onAccelerate( event )
	print("X Gravity : " .. event.xGravity )
	print("Y Gravity : " .. event.yGravity )
end
Runtime:addEventListener ("accelerometer", onAccelerate);

local touchTracker = {} --table.getn(touchTracker) find length of a table, table.insert(touchTracker,1) insert
local lastBlock = 0

local statusText = display.newText("", display.contentCenterX, 15)

local function statusUpdate( ok )
  if (ok == true) then
    statusText.text = "Good!"
  else
    statusText.text = "Bad!"
  end
end

local lastTime = system.getTimer()

local function checkTiming()
      local currentTime = system.getTimer()
      print("Current time: " .. currentTime)
      print("Last time: " .. lastTime)
      local timeDiff = math.abs(lastTime - currentTime)
      lastTime = currentTime
      print(timeDiff)
      if (timeDiff < 1500) then
        return true
      else
        return false
      end
      return true
end

-- startRectangle Touch event listener
local function startRectangleTouchListener( event )
    if ( lastBlock == 1 ) then
      lastBlock = 0
      statusUpdate(checkTiming())
      print("Switched blocks to 0")
      --print(timer)
    end
end

-- finishRectangle Touch event listener
local function finishRectangleTouchListener( event )
    if ( lastBlock == 0 ) then
      lastBlock = 1
      statusUpdate(checkTiming())
      print("Switched blocks to 1")
      --print(system.getTimer)
    end
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
    --local rect1x = math.random(display.actualContentWidth-20)
    --local rect2x = math.random(display.actualContentWidth-20)    
    --local rect1y = math.random(display.contentCenterY-20)
    --local rect2y = math.random(display.contentCenterY,display.actualContentHeight-30)    
  
    local rect1x = display.actualContentWidth/3
    local rect2x = 2 * display.actualContentWidth/3  
    local rect1y = display.contentCenterY
    local rect2y = display.contentCenterY
    
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
    
    statusText = display.newText("NOTHING YET", display.contentCenterX, 15)
    statusText:setFillColor( 1, 1, 1 )
    sceneGroup:insert(statusText)
    
    
    --messing with sprite sheet
    local sheetOptions =
      {
          width = 67,
          height = 105,
          numFrames = 6
      }
      
    local sheet_Ryu = graphics.newImageSheet( "ryu-sprite.png", sheetOptions )
    
    local sequences_Ryu = {
        -- consecutive frames sequence
        {
            name = "normalRun",
            start = 1,
            count = 5,
            time = 800,
            loopCount = 0,
            loopDirection = "forward"
        }
    }

    local ryuSprite= display.newSprite( sheet_Ryu, sequences_Ryu )
    ryuSprite:play()
    ryuSprite.x = display.contentCenterX
    ryuSprite.y = 100
-- sequences table
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