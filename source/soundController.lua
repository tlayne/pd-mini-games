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

    dechargeWav = sd.sample.new("sounds/decharge")
    decharge = sd.sampleplayer.new(dechargeWav)

    specWav = sd.sample.new("sounds/special")
    special = sd.sampleplayer.new(specWav)

    alarmWav = sd.sample.new("sounds/alarm")
    alarm = sd.sampleplayer.new(alarmWav)
end


function loadMusic()
    wyverWav= sd.fileplayer.new("sounds/wyver9")
    wyverWav:load("sounds/wyver9")
    wyverWav:setVolume(0.4)
    wyverWav:play(0)
end

function sampleVolume(sample, volume)
    sample:setVolume(volume)
end

