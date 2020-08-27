local function MetamorphosisCooldownAdjusted()
    -- TODO: Make this better by sampling the Fury expenses over time instead of approximating
    if A.ConvergenceofFates:IsEquipped() and A.DelusionsOfGrandeur:IsEquipped() then
        return A.Metamorphosis:CooldownRemainsP() * 0.56;
    elseif A.ConvergenceofFates:IsEquipped() then
        return A.Metamorphosis:CooldownRemainsP() * 0.78;
    elseif A.DelusionsOfGrandeur:IsEquipped() then
        return A.Metamorphosis:CooldownRemainsP() * 0.67;
    end
    return A.Metamorphosis:CooldownRemainsP()
end

-- FelRush handler
local function UseMoves()
  return Action.GetToggle(2, "UseMoves") --or S.FelRush:Charges() == 2  
end