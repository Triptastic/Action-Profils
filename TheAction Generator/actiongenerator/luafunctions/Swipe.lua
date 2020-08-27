local function Swipe()
  if Unit("player"):HasBuffs(A.CatForm.ID, true) then
    return A.SwipeCat;
  else
    return A.SwipeBear;
  end
end
