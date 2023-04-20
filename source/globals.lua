--Global gamestate variable which indicates what stage the user is at (start, game, boss battle, collection, credits, victory, game over)
gameState = 'start'
-- Change ship speed upwards based on powering up without dying?
shipSpeedMultiplier = 1
enemySpeedMultiplier = 1
lifeCount = 2
shipPower = 0
powerCycle = false
--Controls player power and is represented by stage1 - stage4
powerLevel = "stage1"
bombCount = 0
score = 0
bossCount = 0
crankStat = false
inputEnabled = true
doABarrelRoll = false
achievements = {
    first = false,
    second = false,
    third = false,
    fourth = false,
    fifth = false,
    sixth = false,
    seventh = false,
    eighth = false,
    ninth = false,
    tenth = false
}

