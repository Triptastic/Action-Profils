-- Map
local TMW = TMW 
local CNDT = TMW.CNDT 
local Env = CNDT.Env
local A = Action

A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()]   = true
A.Data.ProfileUI                                     = {
    DateTime = "v7 (23.09.2019)",
    [2]                                             = { LayoutOptions = { gutter = 6, padding = { left = 10, right = 10 } } },
    [7]                                                = {
        ["kick"] = { Enabled = true, Key = "Silence", LUAVER = 1, LUA = [[
                local Obj     = Action[Action.PlayerClass]
                local Temp     = {"TotalImun", "KickImun", "DamageMagicImun", "CCTotalImun", "CCMagicImun"}
                return     Obj.Silence and 
                        Obj.Silence:IsReadyM(thisunit) and 
                        Obj.Silence:AbsentImun(thisunit, Temp) and 
                        Unit(thisunit):IsCastingRemains() > 0 and 
                        Unit(thisunit):IsControlAble("silence") and 
                        LossOfControl:IsMissed("SILENCE") and 
                        LossOfControl:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
            ]] },
        ["fear"] = { Enabled = true, Key = "PsychicScream", LUAVER = 3, LUA = [[
                local Obj     = Action[Action.PlayerClass]
                local Temp     = {"TotalImun", "FearImun"}
                return     Obj.PsychicScream and 
                        Obj.PsychicScream:IsReadyM() and 
                        (
                            MultiUnits:GetByRange(8, 1) >= 1 or 
                            (
                                Obj.PsychicScream:IsReadyM(thisunit, true) and 
                                Obj.PsychicScream:AbsentImun(thisunit, Temp) and 
                                Unit(thisunit):IsControlAble("fear") and 
                                Unit(thisunit):GetRange() <= 8 and 
                                LossOfControl:IsMissed("SILENCE") and 
                                LossOfControl:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
                            )
                        )
            ]] },
    },
}
A.Data.ProfileUI[2]                                = {
            {
				{	
					E = "Header",
					L = { 
						enUS = "--- Rotation ---", 
					}, 
					S = 14,
				},
			},					
			{	-- FeignDeathHP slider						
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "FeignDeathHP",
                    DBV = 20, -- Set default healthpercentage @20% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Feign Death  HP (%)", -- Feign Deaht spell id
                    }, 
                    M = {},
                },
				-- Mend Pet
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "MendPetHP",
                    DBV = 20, -- Set default healthpercentage @20% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Mend Pet HP (%)", -- MendPet spell id
                    }, 
                    M = {},
                },
			},
			{
				-- A Checkbox
				{
					E = "Checkbox", 
					DB = "Shiv",
					DBV = false,
					L = { 
						enUS = "Enable Shiv", 
						ruRU = "?????????????? ?????", 
					}, 
					TT = { 
						enUS = "Enable to use", 
						ruRU = "???????? ??? ?????????????", 
					}, 
					M = {},
				},
			},    
}



-----------------------------------------
--                   PvP  
-----------------------------------------

function A.Main_CastBars(unit, list)
    if not A.IsInitialized or A.IamHealer or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
   -- if A[A.PlayerSpec] and A[A.PlayerSpec].SpearHandStrike and A[A.PlayerSpec].SpearHandStrike:IsReadyP(unit, nil, true) and A[A.PlayerSpec].SpearHandStrike:AbsentImun(unit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and A.InterruptIsValid(unit, list) then 
   --     return true         
   -- end 
end 

function A.Second_CastBars(unit)
    if not A.IsInitialized or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    --local Toggle = A.GetToggle(2, "ParalysisPvP")    
    --if Toggle and Toggle ~= "OFF" and A[A.PlayerSpec] and A[A.PlayerSpec].Paralysis and A[A.PlayerSpec].Paralysis:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Paralysis:AbsentImun(unit, {"CCTotalImun", "TotalImun", "DamagePhysImun"}, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
     --   if Toggle == "BOTH" then 
     --       return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
    --    else
    --        return select(2, A.InterruptIsValid(unit, Toggle, true))         
    --    end 
    --end 
end 
