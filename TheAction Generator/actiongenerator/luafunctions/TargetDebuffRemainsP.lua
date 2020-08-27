local function TargetDebuffRemainsP (Spell, AnyCaster, Offset)
  if Spell == A.Vulnerability and (A.Windburst:IsSpellInFlight() or A.MarkedShot:IsSpellInFlight() or Unit("player"):GetSpellLastCast(A.Windburst.ID, true)) then
    return 7;
  else
    return Unit(unit):HasDeBuffs(Spell);
  end
end
