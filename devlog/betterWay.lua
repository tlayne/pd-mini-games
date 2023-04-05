-- to limit projectiles

function Player:init()
    ...
    self.projectileActive = 0
    self.maxProjectiles = 20
  end
  
  function Player:fireProjectile()
    if self.projectileActive >= self.maxProjectiles then
      return
    end
    ...
    Projectile(self, x, y, xVelocity, yVelocity)
    self.projectileActive += 1
  end
  
  function Player:projectileDestroyed()
    self.projectileActive -= 1
  end
  
  ...
  
  function Projectile:init(player, x, y, xVelocity, yVelocity)
    ...
    self.player = player
  end
  
  function Projectile:destroyed()
    ...
    self.player:projectileDestroyed()
    self:remove()
  end

  -- to manage signals (a library perhaps)

  -- to store references in a manager that can be accessed from anywhere while not being global.

  -- to use the crank (this thing is an enigma)