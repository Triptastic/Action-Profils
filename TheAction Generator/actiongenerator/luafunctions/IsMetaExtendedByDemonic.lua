local function IsMetaExtendedByDemonic()
  if not Player:BuffP(A.MetamorphosisBuff) then
    return false;
  elseif(A.EyeBeam:TimeSinceLastCast() < A.MetamorphosisImpact:TimeSinceLastCast()) then
    return true;
  end

  return false;
end
