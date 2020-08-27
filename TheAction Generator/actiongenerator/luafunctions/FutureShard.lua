local function FutureShard ()
    local Shard = Player:SoulShards()
    local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit("player"):IsCasting()
    
    if not Unit("player"):IsCasting() then
        return Shard
    else
        if spellID = A.UnstableAffliction.ID 
                or spellID = A.SeedOfCorruption.ID then
            return Shard - 1
        elseif spellID = A.SummonDoomGuard.ID 
                or spellID = A.SummonDoomGuardSuppremacy.ID 
                or spellID = A.SummonInfernal.ID
                or spellID = A.SummonInfernalSuppremacy.ID 
                or spellID = A.GrimoireFelhunter.ID 
                or spellID = A.SummonFelhunter.ID then
            return Shard - 1
        else
            return Shard
        end
    end
end
