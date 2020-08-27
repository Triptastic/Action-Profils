-- A1 Eye of Leotheras
local A = Action
local EoL_Toggle = A.GetToggle(2, "LeotherasPvP")
return
--EoL_Toggle ~= "OFF" and
A.Unit("player"):HasSpec(577) and -- Havoc
A.IsSpellLearned(206649) and
select(2, GetSpellCooldown(206649)) == 0 and
A.IsSpellInRange(206649, thisobj.Unit) and
A.Unit(thisobj.Unit):HasDeBuffs(206649, true) == 0 and
(
    EoL_Toggle == "ON CD" or
    (
        EoL_Toggle == "ON ENEMY BURST" and
        A.Unit(thisobj.Unit):HasBuffs("DamageBuffs") > 0
    ) or
    (
        EoL_Toggle == "ON TEAM DEFF" and
        (
            (                
                not A.Unit(thisobj.Unit .. "target"):IsEnemy() and
                A.Unit(thisobj.Unit .. "target"):IsPlayer() and
                (
                    A.Unit(thisobj.Unit  .. "target"):HasBuffs("DeffBuffs")>4 or
                    A.Unit(thisobj.Unit  .. "target"):TimeToDie() <= 6 or
                    A.Unit(thisobj.Unit  .. "target"):Health() <=
                    A.Unit(thisobj.Unit  .. "target"):HealthMax() * 0.6
                )
            ) or
            A.Unit("player"):UseDeff() or
            A.FriendlyTeam("HEALER"):GetCC() >= 3
        )
    ) 
	--or
    --(
    --    EoL_Toggle == "MARKED" and
    --    EoL_Mark[UnitGUID(thisobj.Unit)]
    --)
) and
A.Unit(thisobj.Unit):HasBuffs("TotalImun") == 0 and
A.Unit(thisobj.Unit):HasBuffs("DamageMagicImun") == 0 and
A.Unit(thisobj.Unit):HasBuffs("Reflect") == 0 and
A.Unit(thisobj.Unit):HasBuffs("CCTotalImun") == 0 and
A.Unit(thisobj.Unit):HasBuffs("CCMagicImun") == 0

