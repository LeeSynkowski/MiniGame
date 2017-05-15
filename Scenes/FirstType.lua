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
local statusText = display.newText("", display.contentCenterX, display.contentHeight- 16)

local function onAccelerate( event )
	statusText.text = "   Xgv: " .. string.format("%0.4f", event.xGravity) ..
                    "   Ygv: " .. string.format("%0.4f", event.yGravity)  .. 
                    "   Zgv: " .. string.format("%0.4f", event.zGravity) 
end

Runtime:addEventListener ("accelerometer", onAccelerate);

local function baseTiltListener(event)
  
end

local touchTracker = {} --table.getn(touchTracker) find length of a table, table.insert(touchTracker,1) insert
local lastBlock = 0

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

-- attack button Touch event listener
local function attackButtonTouchListener( event )
  statusText.text = "Attack!"
end

-- counter button Touch event listener
local function counterButtonTouchListener( event )
  statusText.text = "Counter!"
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    -- Create Background
    local background = display.newRect( display.contentCenterX, 
                                        display.contentCenterY, 
                                        display.contentWidth,
                                        display.contentHeight)
    background:setFillColor( .1, .5, .5 )
    sceneGroup:insert( background )

    local rect1X = display.contentWidth/6
    local rect2X = 2 * display.contentWidth/6  
    local rect1Y = 3 * display.contentHeight/4
    local rect2Y = 3 * display.contentHeight/4
    local rectWidth = 20
    local rectHeight = 50
    
    local attackX = 4 * display.contentWidth/6
    local attackY = 3 * display.contentHeight/4
    local counterX = 5 * display.contentWidth/6
    local counterY = 3 * display.contentHeight/4
    local attackRadius = 20
    local counterRadius = 20
    
    local baseRectX = display.contentCenterX
    local baseRectY = (display.contentHeight/3)/2
    local baseRectWidth = display.contentWidth/3
    local baseRectHeight = display.contentHeight/3
    
    local baseCircleX = display.contentCenterX
    local baseCircleY = (display.contentHeight/3)/2
    local baseCircleRadius = display.contentHeight/12
    
    --Timing Start Rectangle
    local startRectangle = display.newRect( rect1X, rect1Y, rectWidth, rectHeight )
    startRectangle:setFillColor( 0, 1, 0 )
    startRectangle:addEventListener( "touch", startRectangleTouchListener)
    sceneGroup:insert( startRectangle )
    --label
    local label1 = display.newText("1", rect1X, rect1Y, rectWidth, rectHeight )
    label1:setFillColor( 0, 0, 0 )
    sceneGroup:insert( label1 )    

    --Timing Finish Rectangle
    local finishRectangle = display.newRect( rect2X, rect2Y, rectWidth, rectHeight,native.systemFont, 20 )    
    finishRectangle:setFillColor( 1, 0, 0 )
    finishRectangle:addEventListener( "touch", finishRectangleTouchListener)
    sceneGroup:insert( finishRectangle ) 
    --label
    local label2 = display.newText("2", rect2X, rect2Y, rectWidth, rectHeight )
    label1:setFillColor( 0, 0, 0 )
    sceneGroup:insert( label2 )
    
    --Attack Button
    local attackButton = display.newCircle(attackX,attackY,attackRadius)
    attackButton:setFillColor(0,0,1)
    attackButton:addEventListener("touch",attackButtonTouchListener)
    sceneGroup:insert(attackButton)
    --label
    local attackLabel = display.newText("Attack", attackX ,attackY , attackRadius, attackRadius )
    label1:setFillColor( 0, 0, 0 )
    sceneGroup:insert( attackLabel )    
    
    --Counter Button
    local counterButton = display.newCircle(counterX,counterY,counterRadius)
    counterButton:setFillColor(0,0,1)
    counterButton:addEventListener("touch",counterButtonTouchListener)
    sceneGroup:insert(counterButton)
    --label
    local counterLabel = display.newText("Counter", counterX, counterY, counterRadius, counterRadius )
    label1:setFillColor( 0, 0, 0 )
    sceneGroup:insert( counterLabel ) 
    
    --Base Display
    local baseRectangle = display.newRect(baseRectX,baseRectY,baseRectWidth,baseRectHeight)
    baseRectangle:setStrokeColor(0,0,0)
    baseRectangle:setFillColor(1,1,1)
    sceneGroup:insert(baseRectangle)
    
    baseCircle = display.newCircle(baseCircleX,baseCircleY,baseCircleRadius)
    baseCircle:setFillColor(1,0,0)
    sceneGroup:insert(baseCircle)

    
    --Status Message Text
    statusText = display.newText("NOTHING YET", display.contentCenterX, display.contentHeight- 16)
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
    ryuSprite.y = display.contentCenterY
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