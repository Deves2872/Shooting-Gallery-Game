function love.load()
  target={}
  target.x=250
  target.y=250
  target.radius=50
  Font=love.graphics.newFont(40)
  score=0
  timer=0
  gameState=1
  images={}
  images.sky=love.graphics.newImage('imgs/sky.png')
  images.crosshairs=love.graphics.newImage('imgs/crosshairs.png')
  images.target=love.graphics.newImage('imgs/target.png')
  love.mouse.setVisible(false)
end

function love.update(dt)
  if timer>0 then
    timer=timer-dt
  end
  if timer<0 and gameState==2 then
    timer=3
    gameState=3
  end
  if timer<0 and gameState==3 then
    timer=0
    gameState=1
  end
end

function love.draw()
  love.graphics.draw(images.sky, 0, 0)
  love.graphics.setFont(Font)
  if gameState==1 then
    love.graphics.setColor(1,1,0)
    love.graphics.printf("SHOOTING GAME!!",0,0,love.graphics.getWidth(),"center")
    love.graphics.setColor(1,0.63,0)
    love.graphics.printf("Right click to start the game!!",0,250,love.graphics.getWidth(),"center")
    love.graphics.setColor(1,0.34,0)
    love.graphics.printf("Made By: Deves Patil",0,500,love.graphics.getWidth(),"center")
    love.graphics.setColor(1,1,1)
    love.graphics.draw(images.crosshairs,love.mouse.getX()-20,love.mouse.getY()-20)
  end
  if gameState==2 then
    love.graphics.print("Score:"..score,0,0)
    love.graphics.print("Timer:"..math.ceil(timer),love.graphics.getWidth()/2,0)
    love.graphics.setColor(0, 0, 0)
    love.graphics.line(0, 45, love.graphics.getWidth(), 45)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(images.target,target.x-target.radius,target.y-target.radius)
    love.graphics.draw(images.crosshairs,love.mouse.getX()-20,love.mouse.getY()-20)
  end
  if gameState==3 then
    love.graphics.printf("GAME OVER!!\nYour Score:"..score,0,250,love.graphics.getWidth(),"center")
    love.graphics.draw(images.crosshairs,love.mouse.getX()-20,love.mouse.getY()-20)
  end
end

function love.mousepressed(x, y, button, isTouch)
  if button==1 and gameState==2 then
    if(distance(target.x,target.y,x,y)<target.radius) then
      score=score+1
      target.x=math.random(target.radius+40,love.graphics.getWidth()-target.radius)
      target.y=math.random(target.radius+40,love.graphics.getHeight()-target.radius)
    else
      if score>0 then
        score=score-1
      end
    end
  end
  if gameState==1 and button==1 then
    gameState=2
    timer=10
    score=0
  end
end

function distance(x1,y1,x2,y2)
  return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end
