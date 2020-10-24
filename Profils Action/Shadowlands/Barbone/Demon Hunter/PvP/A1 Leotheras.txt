-- A1 Eye of Leotheras
return
EoL_Toggle ~= "OFF" and
UNITSpec("player", 577) and -- Havoc
PvPTalentLearn(206649) and
SpellCD(206649) == 0 and
SpellInRange(thisobj.Unit, 206649) and
DeBuffs(thisobj.Unit, 206649, "player") == 0 and
(
    EoL_Toggle == "ON CD" or
    (
        EoL_Toggle == "ON ENEMY BURST" and
        PvPBuffs(thisobj.Unit, "DamageBuffs") > 0
    ) or
    (
        EoL_Toggle == "ON TEAM DEFF" and
        (
            (                
                not UNITEnemy(thisobj.Unit .. "target") and
                UnitIsPlayer(thisobj.Unit  .. "target") and
                (
                    PvPBuffs(thisobj.Unit  .. "target", "DeffBuffs")>4 or
                    TimeToDie(thisobj.Unit  .. "target") <= 6 or
                    UnitHealth(thisobj.Unit  .. "target") <=
                    UnitHealthMax(thisobj.Unit  .. "target") * 0.6
                )
            ) or
            oDH["PvPNeedDeffMe"] or
            oDH["PvPFriendlyHealerCC_Duration"] >= 3
        )
    ) or
    (
        EoL_Toggle == "MARKED" and
        EoL_Mark[UnitGUID(thisobj.Unit)]
    )
) and
PvPBuffs(thisobj.Unit, "TotalImun") == 0 and
PvPBuffs(thisobj.Unit, "DamageMagicImun") == 0 and
PvPBuffs(thisobj.Unit, "Reflect") == 0 and
PvPBuffs(thisobj.Unit, "CCTotalImun") == 0 and
PvPBuffs(thisobj.Unit, "CCMagicImun") == 0

