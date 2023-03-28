local pd <const> = playdate
local gfx <const> = pd.graphics
local sd <const> = pd.sound

function loadSounds()
    laserWav = sd.sample.new("sounds/laser")
    laser = sd.sampleplayer.new(laserWav)

    killWav = sd.sample.new("sounds/kill")
    kill = sd.sampleplayer.new(killWav)

    sonicWav = sd.sample.new("sounds/sonic")
    sonic = sd.sampleplayer.new(sonicWav)

    splodWav = sd.sample.new("sounds/splode")
    splod = sd.sampleplayer.new(splodWav)

    spinWav = sd.sample.new("sounds/spin")
    spin = sd.sampleplayer.new(spinWav)
end



