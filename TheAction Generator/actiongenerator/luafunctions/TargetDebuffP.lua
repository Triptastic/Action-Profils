local function TargetDebuffP (Spell, AnyCaster, Offset)
  if Spell == A.Vulnerability then
    return Unit(unit):HasDeBuffs(Spell) or A.Windburst:IsSpellInFlight() or A.MarkedShot:IsSpellInFlight() or Unit("player"):GetSpellLastCast(A.Windburst.ID, true);
  elseif Spell == A.HuntersMark then
    return Unit(unit):HasDeBuffs(Spell) or A.ArcaneShot:IsSpellInFlight() or A.MultiShot:IsSpellInFlight() or A.Sidewinders:IsSpellInFlight();
  else
    return Unit(unit):HasDeBuffs(Spell);
  end
end
