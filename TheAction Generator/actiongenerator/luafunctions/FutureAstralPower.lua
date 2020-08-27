local function FutureAstralPower()
    local AstralPower=Player:AstralPower()
    local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit("player"):IsCasting()
        
    if not Unit("player"):IsCasting() then
        return AstralPower
    else
        if spellID = A.NewMoon.ID then
            return AstralPower + 10
        elseif spellID = A.HalfMoon.ID then
            return AstralPower + 20
        elseif spellID = A.FullMoon.ID then
            return AstralPower + 40
        elseif spellID = A.StellarFlare.ID then
            return AstralPower + 8
        elseif spellID = A.SolarWrath.ID then
            return AstralPower + 8
        elseif spellID = A.LunarStrike.ID then
            return AstralPower + 12
        else
            return AstralPower
        end
    end
end
