local function Thrash()
  if Unit("player"):HasBuffs(A.CatForm.ID, true) then
    return A.ThrashCat;
  else
    return A.ThrashBear;
  end
end
