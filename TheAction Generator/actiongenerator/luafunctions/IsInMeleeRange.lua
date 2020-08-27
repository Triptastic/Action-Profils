local function IsInMeleeRange()
  if A.Felblade:GetSpellTimeSinceLastCast() <= A.GetGCD() then
    return true
  elseif A.VengefulRetreat:GetSpellTimeSinceLastCast() < 1.0 then  
    return false
  end
  return A.ChaosStrike:IsInRange(unit)
end
