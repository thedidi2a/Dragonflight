--##################################
--##### TRIP'S MISTWEAVER MONK #####
--##################################

local _G, setmetatable							= _G, setmetatable
local math_random                        		= math.random
local A                         			    = _G.Action
local TMW										= _G.TMW
local Listener									= Action.Listener
local Create									= Action.Create
local GetToggle									= Action.GetToggle
local SetToggle									= Action.SetToggle
local GetGCD									= Action.GetGCD
local GetCurrentGCD								= Action.GetCurrentGCD
local GetPing									= Action.GetPing
local ShouldStop								= Action.ShouldStop
local BurstIsON									= Action.BurstIsON
local AuraIsValid								= Action.AuraIsValid
local InterruptIsValid							= Action.InterruptIsValid
local HealingEngine                            = Action.HealingEngine
local FrameHasSpell                             = Action.FrameHasSpell
local Utils										= Action.Utils
local TeamCache									= Action.TeamCache
local EnemyTeam									= Action.EnemyTeam
local FriendlyTeam								= Action.FriendlyTeam
local LoC										= Action.LossOfControl
local Player									= Action.Player
local Pet                                       = LibStub("PetLibrary") 
local MultiUnits								= Action.MultiUnits
local UnitCooldown								= Action.UnitCooldown
local Unit										= Action.Unit 
local IsUnitEnemy								= Action.IsUnitEnemy
local IsUnitFriendly							= Action.IsUnitFriendly
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local pairs                                     = pairs

--For Toaster
local Toaster									= _G.Toaster
local GetSpellTexture 							= _G.TMW.GetSpellTexture

Action[ACTION_CONST_MONK_MISTWEAVER] = {
	--Racial 
    ArcaneTorrent				= Action.Create({ Type = "Spell", ID = 50613	}),
    BloodFury					= Action.Create({ Type = "Spell", ID = 20572	}),
    Fireblood					= Action.Create({ Type = "Spell", ID = 265221	}),
    AncestralCall				= Action.Create({ Type = "Spell", ID = 274738	}),
    Berserking					= Action.Create({ Type = "Spell", ID = 26297	}),
    ArcanePulse             	= Action.Create({ Type = "Spell", ID = 260364	}),
    QuakingPalm           		= Action.Create({ Type = "Spell", ID = 107079	}),
    Haymaker           			= Action.Create({ Type = "Spell", ID = 287712	}), 
    BullRush           			= Action.Create({ Type = "Spell", ID = 255654	}),    
    WarStomp        			= Action.Create({ Type = "Spell", ID = 20549	}),
    GiftofNaaru   				= Action.Create({ Type = "Spell", ID = 59544	}),
    Shadowmeld   				= Action.Create({ Type = "Spell", ID = 58984    }),
    Stoneform 					= Action.Create({ Type = "Spell", ID = 20594    }), 
    BagofTricks					= Action.Create({ Type = "Spell", ID = 312411	}),
    WilloftheForsaken			= Action.Create({ Type = "Spell", ID = 7744		}),   
    EscapeArtist				= Action.Create({ Type = "Spell", ID = 20589    }), 
    EveryManforHimself			= Action.Create({ Type = "Spell", ID = 59752    }),
    LightsJudgment				= Action.Create({ Type = "Spell", ID = 255647   }), 	
	
	--General
    BlackoutKick				= Action.Create({ Type = "Spell", ID = 100784   }), 
	CracklingJadeLightning		= Action.Create({ Type = "Spell", ID = 117952   }),
	ExpelHarm					= Action.Create({ Type = "Spell", ID = 322101   }),
	LegSweep					= Action.Create({ Type = "Spell", ID = 119381   }),
	Provoke						= Action.Create({ Type = "Spell", ID = 115546   }),
	Resuscitate					= Action.Create({ Type = "Spell", ID = 115178   }),
	Roll						= Action.Create({ Type = "Spell", ID = 109132   }), 
	SoothingMist				= Action.Create({ Type = "Spell", ID = 115175   }),
	SpinningCraneKick			= Action.Create({ Type = "Spell", ID = 101546   }),
	TigerPalm					= Action.Create({ Type = "Spell", ID = 100780   }),
	TouchofDeath				= Action.Create({ Type = "Spell", ID = 322109   }),
	Vivify						= Action.Create({ Type = "Spell", ID = 116670   }), 
	Paralysis					= Action.Create({ Type = "Spell", ID = 115078   }),	
	SpearHandStrike				= Action.Create({ Type = "Spell", ID = 116705   }),
	RisingSunKick				= Action.Create({ Type = "Spell", ID = 107428   }),
	Transcendence				= Action.Create({ Type = "Spell", ID = 101643   }),	
	ChiTorpedo					= Action.Create({ Type = "Spell", ID = 115008   }),
	ChiBurst					= Action.Create({ Type = "Spell", ID = 123986   }),	
	RingofPeace					= Action.Create({ Type = "Spell", ID = 116844   }),	
	ChiWave						= Action.Create({ Type = "Spell", ID = 115098   }),
	DisableMag					= Action.Create({ Type = "Spell", ID = 116095   }),	
	DampenHarm					= Action.Create({ Type = "Spell", ID = 122278   }),	
	TigersLust					= Action.Create({ Type = "Spell", ID = 116841   }),	
	FortifyingBrew				= Action.Create({ Type = "Spell", ID = 388917   }),
	SummonWhiteTigerStatue		= Action.Create({ Type = "Spell", ID = 388686   }),	

	--Mistweaver
	Reawaken					= Action.Create({ Type = "Spell", ID = 212051   }), 
	Detox						= Action.Create({ Type = "Spell", ID = 115450   }), 
	BonedustBrew				= Action.Create({ Type = "Spell", ID = 386276   }),
	DiffuseMagic				= Action.Create({ Type = "Spell", ID = 122783   }),
	EnvelopingMist				= Action.Create({ Type = "Spell", ID = 124682   }),
	EssenceFont					= Action.Create({ Type = "Spell", ID = 191837   }), 
	FaelineStomp				= Action.Create({ Type = "Spell", ID = 388193   }),   	
	HealingElixir				= Action.Create({ Type = "Spell", ID = 122281   }), 
	InvokeChiji					= Action.Create({ Type = "Spell", ID = 325197   }), 	
	InvokeYulon					= Action.Create({ Type = "Spell", ID = 322118   }),
	LifeCocoon					= Action.Create({ Type = "Spell", ID = 116849   }), 
	ManaTea						= Action.Create({ Type = "Spell", ID = 197908   }),	
	RefreshingJadeWind			= Action.Create({ Type = "Spell", ID = 196725   }),
	RenewingMist				= Action.Create({ Type = "Spell", ID = 115151   }),
	Restoral					= Action.Create({ Type = "Spell", ID = 388615   }),
	Revival						= Action.Create({ Type = "Spell", ID = 115310   }),
	SongofChiJi					= Action.Create({ Type = "Spell", ID = 198898   }),
	SummonJadeSerpentStatue		= Action.Create({ Type = "Spell", ID = 115313   }),
	ThunderFocusTea				= Action.Create({ Type = "Spell", ID = 116680   }),	
	ZenPulse					= Action.Create({ Type = "Spell", ID = 124081   }),	
	
	--Buffs/Talents
	AncientConcordance			= Action.Create({ Type = "Spell", ID = 389391   }),	
	TeachingsoftheMonastery		= Action.Create({ Type = "Spell", ID = 202090   }),	
	AncientTeachings			= Action.Create({ Type = "Spell", ID = 388026   }),		
	CloudedFocus				= Action.Create({ Type = "Spell", ID = 388047   }),	
	InvigoratingMists			= Action.Create({ Type = "Spell", ID = 274586   }),		
	VivaciousVivification		= Action.Create({ Type = "Spell", ID = 392883   }),		
	YulonsBlessing				= Action.Create({ Type = "Spell", ID = 389422   }),	
	ChiJisBlessing				= Action.Create({ Type = "Spell", ID = 343820   }),	
	RisingMist					= Action.Create({ Type = "Spell", ID = 274909   }),		
	Healthstone     = Action.Create({ Type = "Spell", ID = 5512 }),
	SpiritofRedemption				= Action.Create({ Type = "Spell", ID = 27827, Hidden = true   }),
	SpiritoftheRedeemer				= Action.Create({ Type = "Spell", ID = 215982   }),	
	ArcaneBravery					= Action.Create({ Type = "Spell", ID = 385841, Hidden = true   }),	
	GrievousWounds					= Action.Create({ Type = "Spell", ID = 240559, Hidden = true   }),
}

local A = setmetatable(Action[ACTION_CONST_MONK_MISTWEAVER], { __index = Action })

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

local player = "player"
local target = "target"
local pet = "pet"
local targettarget = "targettarget"
local focus = "focus"

local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
	TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
	TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
	useVivify								= false,
}

TMW:RegisterCallback("TMW_ACTION_HEALINGENGINE_UNIT_UPDATE", function(callbackEvent, thisUnit, db, QueueOrder)
	local unitID  = thisUnit.Unit
	local unitHP  = thisUnit.realHP
	local Role    = thisUnit.Role
	local BlanketRenewingMist = A.GetToggle(2, "BlanketRenewingMist")
	local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unitID)	
	local delaySpells = math_random(500, 1000) / 100
	local Cleanse = A.GetToggle(2, "Cleanse")	
	
	if (BlanketRenewingMist and thisUnit.useHoTs and not QueueOrder.useHoTs[Role] and A.RenewingMist:IsReady(unitID) and Unit(unitID):HasBuffs(A.RenewingMist.ID, true) == 0) or ((Unit(player):HasBuffs(A.YulonsBlessing.ID) > 0 or Unit(player):HasBuffsStacks(A.ChiJisBlessing.ID) >= 3) and thisUnit.useHoTs and not QueueOrder.useHoTs[Role] and A.EnvelopingMist:IsReady(unitID) and Unit(unitID):HasBuffs(A.EnvelopingMist.ID, true) == 0) then 
		QueueOrder.useHoTs[Role] = true 
		local default = unitHP - 10
			
		if Role == "TANK" then
			thisUnit:SetupOffsets(db.OffsetTanksHoTs, default)
		elseif Role == "HEALER" then 
			thisUnit:SetupOffsets(db.OffsetHealersHoTs, default)
		else 
			thisUnit:SetupOffsets(db.OffsetDamagersHoTs, default)
		end     
		return
	end 
	-- Dispel
	if A.Detox:IsReady(unitID) and A.Detox:IsSuspended(delaySpells, 6) and Cleanse then
		if thisUnit.useDispel and not QueueOrder.useDispel[Role] and AuraIsValid(unitID, "UseDispel", "Dispel") then
			QueueOrder.useDispel[Role] = true
		
			if thisUnit.isSelf then
				thisUnit:SetupOffsets(db.OffsetSelfDispel, - 40)
			elseif Role == "HEALER" then
				thisUnit:SetupOffsets(db.OffsetHealersDispel, - 35)
			elseif Role == "TANK" then
				thisUnit:SetupOffsets(db.OffsetTanksDispel, - 25)
			else
				thisUnit:SetupOffsets(db.OffsetDamagersDispel, - 30)
			end
		
			return
		end
	end		
	--SpiritofRedemption
	if Unit(unitID):HasBuffs(A.SpiritoftheRedeemer.ID) > 0 or Unit(unitID):HasBuffs(A.SpiritofRedemption.ID) > 0 or Unit(unitID):HasBuffs(A.ArcaneBravery.ID) > 0 then
		thisUnit.Enabled = false
	else thisUnit.Enabled = true
	end
end)

local function SelfDefensives()
    local AllowOverlap = A.GetToggle(2, "AllowOverlap")
	local HealingElixirHP = A.GetToggle(2, "HealingElixirHP")	
	local FortifyingBrewHP = A.GetToggle(2, "FortifyingBrewHP")
    local DampenHarmHP = A.GetToggle(2, "DampenHarmHP")	
	
	if Unit(player):CombatTime() == 0 then 
        return 
    end 

	if A.CanUseHealthstoneOrHealingPotion() then
		return A.Healthstone
	end

	if A.HealingElixir:IsReady(player) and Unit(player):HealthPercent() <= HealingElixirHP then
		return A.HealingElixir
	end
	
	if A.FortifyingBrew:IsReady(player) and Unit(player):HealthPercent() <= FortifyingBrewHP and (Unit(player):HasBuffs(A.DampenHarm.ID) == 0 or AllowOverlap) then
		return A.FortifyingBrew
	end
	
	if A.DampenHarm:IsReady(player) and Unit(player):HealthPercent() <= DampenHarmHP and (Unit(player):HasBuffs(A.FortifyingBrew.ID) == 0 or AllowOverlap) then
		return A.DampenHarm
	end

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function Interrupts(unitID)
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
	
	if castRemainsTime >= A.GetLatency() then
        if useKick and not notInterruptable and A.SpearHandStrike:IsReady(unitID) then 
            return A.SpearHandStrike
        end
		
        if useCC and not notInterruptable and A.LegSweep:IsReady(unitID) then 
            return A.LegSweep
        end		
		    
   	    if useRacial and A.QuakingPalm:AutoRacial(unitID) then 
   	        return A.QuakingPalm
   	    end 
    
   	    if useRacial and A.Haymaker:AutoRacial(unitID) then 
            return A.Haymaker
   	    end 
    
   	    if useRacial and A.WarStomp:AutoRacial(unitID) then 
            return A.WarStomp
   	    end 
    
   	    if useRacial and A.BullRush:AutoRacial(unitID) then 
            return A.BullRush
   	    end 
    end
end

local function UseTrinkets(unitID)
	local TrinketType1 = A.GetToggle(2, "TrinketType1")
	local TrinketType2 = A.GetToggle(2, "TrinketType2")
	local TrinketValue1 = A.GetToggle(2, "TrinketValue1")
	local TrinketValue2 = A.GetToggle(2, "TrinketValue2")	

	if A.Trinket1:IsReady(unitID) then
		if TrinketType1 == "Damage" then
			if A.BurstIsON(unitID) and A.IsUnitEnemy(unitID) then
				return A.Trinket1
			end
		elseif TrinketType1 == "Friendly" and A.IsUnitFriendly(unitID) then
			if Unit(unitID):HealthPercent() <= TrinketValue1 then
				return A.Trinket1
			end	
		elseif TrinketType1 == "SelfDefensive" then
			if Unit(player):HealthPercent() <= TrinketValue1 then
				return A.Trinket1
			end	
		elseif TrinketType1 == "ManaGain" then
			if Unit(player):PowerPercent() <= TrinketValue1 then
				return A.Trinket1
			end
		end	
	end

	if A.Trinket2:IsReady(unitID) then
		if TrinketType2 == "Damage" then
			if A.BurstIsON(unitID) and A.IsUnitEnemy(unitID) then
				return A.Trinket2
			end
		elseif TrinketType2 == "Friendly" and A.IsUnitFriendly(unitID) then
			if Unit(unitID):HealthPercent() <= TrinketValue2 then
				return A.Trinket2
			end	
		elseif TrinketType2 == "SelfDefensive" then
			if Unit(player):HealthPercent() <= TrinketValue2 then
				return A.Trinket2
			end	
		elseif TrinketType2 == "ManaGain" then
			if Unit(player):PowerPercent() <= TrinketValue2 then
				return A.Trinket2
			end
		end	
	end

end

local function HealCalc(heal)

	local healamount = 0
	local globalhealmod = A.GetToggle(2, "globalhealmod")
	
	local bonusHeal = GetSpellBonusHealing() -- Healing bonus
	
	if heal == A.Vivify then
		healamount = (A.Vivify:GetSpellDescription()[2]+(1.41*bonusHeal))
	elseif heal == A.ExpelHarm then
		healamount = (A.ExpelHarm:GetSpellDescription()[2]+(1.2*bonusHeal))
	end

	return healamount * globalhealmod

end

local function EmergencyHealing(unitID)

	local EmergencyHP = A.GetToggle(2, "EmergencyHP")
	local Emergency
	
	if EmergencyHP >= 100 then
		Emergency = Unit(unitID):HealthPercent() <= 30
	elseif EmergencyHP <= 99 then
		Emergency = Unit(unitID):HealthPercent() <= EmergencyHP
	end
	
	if Emergency then
		if A.LifeCocoon:IsReady(unitID) then
			return A.LifeCocoon
		end
	end

end

local function AoECDs()

	local RevivalHP = A.GetToggle(2, "RevivalHP")
	local RevivalTargets = A.GetToggle(2, "RevivalTargets")	
	local ChiJiHP = A.GetToggle(2, "ChiJiHP")
	local ChiJiTargets = A.GetToggle(2, "ChiJiTargets")	

	if RevivalTargets > 5 and TeamCache.Friendly.Size > 5 then
		RevivalTargets = 5
	end

	if ChiJiTargets > 5 and TeamCache.Friendly.Size > 5 then
		ChiJiTargets = 5
	end

	if A.Revival:IsReady(player) or A.Restoral:IsReady(player) then
		if RevivalHP >= 100 then
			if RevivalTargets >= 25 then
				if HealingEngine.GetBelowHealthPercentUnits(65, 40) >= 20 then
					if A.Revival:IsReady(player) then
						return A.Revival
					elseif A.Restoral:IsReady(player) then
						return A.Restoral
					end
				end
			end
			if RevivalTargets <= 24 then
				if HealingEngine.GetBelowHealthPercentUnits(65, 40) >= RevivalTargets then
					if A.Revival:IsReady(player) then
						return A.Revival
					elseif A.Restoral:IsReady(player) then
						return A.Restoral
					end
				end	
			end
		elseif RevivalHP <= 99 then 
			if RevivalTargets >= 25 then
				if HealingEngine.GetBelowHealthPercentUnits(65, 40) >= 20 then
					if A.Revival:IsReady(player) then
						return A.Revival
					elseif A.Restoral:IsReady(player) then
						return A.Restoral
					end
				end
			end
			if RevivalTargets <= 24 then
				if HealingEngine.GetBelowHealthPercentUnits(65, 40) >= RevivalTargets then
					if A.Revival:IsReady(player) then
						return A.Revival
					elseif A.Restoral:IsReady(player) then
						return A.Restoral
					end
				end	
			end
		end
	end
	
	if A.InvokeChiji:IsReady(player) or A.InvokeYulon:IsReady(player) then
		if ChiJiHP >= 100 then
			if ChiJiTargets >= 25 then
				if HealingEngine.GetBelowHealthPercentUnits(65, 40) >= 20 then
					if A.InvokeChiji:IsReady(player) then
						return A.InvokeChiji
					elseif A.InvokeYulon:IsReady(player) then
						return A.InvokeYulon
					end
				end
			end
			if ChiJiTargets <= 24 then
				if HealingEngine.GetBelowHealthPercentUnits(65, 40) >= ChiJiTargets then
					if A.InvokeChiji:IsReady(player) then
						return A.InvokeChiji
					elseif A.InvokeYulon:IsReady(player) then
						return A.InvokeYulon
					end
				end	
			end
		elseif ChiJiHP <= 99 then 
			if ChiJiTargets >= 25 then
				if HealingEngine.GetBelowHealthPercentUnits(65, 40) >= 20 then
					if A.InvokeChiji:IsReady(player) then
						return A.InvokeChiji
					elseif A.InvokeYulon:IsReady(player) then
						return A.InvokeYulon
					end
				end
			end
			if ChiJiTargets <= 24 then
				if HealingEngine.GetBelowHealthPercentUnits(65, 40) >= ChiJiTargets then
					if A.InvokeChiji:IsReady(player) then
						return A.InvokeChiji
					elseif A.InvokeYulon:IsReady(player) then
						return A.InvokeYulon
					end
				end	
			end
		end
	end	
end

local function CancelSoothingMist()

	local getmembersAll = HealingEngine.GetMembersAll()			
	if Player:IsChanneling() == A.SoothingMist:Info() then
		for i = 1, #getmembersAll do 
			if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HasBuffs(A.SoothingMist.ID, true) > 0 and Unit(getmembersAll[i].Unit):HealthPercent() > 80 then  
				return A:Show(icon, ACTION_CONST_STOPCAST)				                									
			end				
		end
	end
end

A[3] = function(icon, isMulti)
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
	local UseAoE = A.GetToggle(2, "AoE")

		local function EnemyRotation(unitID)
		
			if A.TouchofDeath:IsReady(unitID) then
				return A.TouchofDeath:Show(icon)
			end
		
			if A.SummonWhiteTigerStatue:IsReady(player) and not isMoving and MultiUnits:GetByRange(3, 15) >= 3 and UseAoE then
				return A.SummonWhiteTigerStatue:Show(icon)
			end
			
			if A.BlackoutKick:IsReady(unitID) and Unit(player):HasBuffs(A.AncientConcordance.ID) > 0 and MultiUnits:GetByRange(3, 10) >= 3 then
				return A.BlackoutKick:Show(icon)
			end
			
			if A.TigerPalm:IsReady(unitID) and A.AncientConcordance:IsTalentLearned() and A.BlackoutKick:GetCooldown() > 0 and Unit(player):HasBuffsStacks(A.TeachingsoftheMonastery.ID) < 3 and A.TeachingsoftheMonastery:IsTalentLearned() then
				return A.TigerPalm:Show(icon)
			end
			
			if A.SpinningCraneKick:IsReady(player) and MultiUnits:GetByRange(5, 10) >= 5 and UseAoE then
				return A.SpinningCraneKick:Show(icon)
			end
			
			if A.FaelineStomp:IsReady(player) and A.TigerPalm:IsInRange(unitID) then
				return A.FaelineStomp:Show(icon)
			end
			
			if A.SpinningCraneKick:IsReady(player) and MultiUnits:GetByRange(3, 10) >= 3 and UseAoE then
				return A.SpinningCraneKick:Show(icon)
			end
			
			if A.RisingSunKick:IsReady(unitID) then
				if A.ThunderFocusTea:IsReady(player) and A.RisingMist:IsTalentLearned() then
					return A.ThunderFocusTea:Show(icon)
				end			
				return A.RisingSunKick:Show(icon)
			end
			
			if A.SpinningCraneKick:IsReady(player) and MultiUnits:GetByRange(2, 10) >= 2 and UseAoE then
				return A.SpinningCraneKick:Show(icon)
			end			
			
			if A.BlackoutKick:IsReady(unitID) then
				return A.BlackoutKick:Show(icon)
			end
			
			if A.TigerPalm:IsReady(unitID) then
				return A.TigerPalm:Show(icon)
			end
			
		end

		local function HealingRotation(unitID)
			
			local LifeCocoonHP = A.GetToggle(2, "LifeCocoonHP")
			local VivifyHP = A.GetToggle(2, "VivifyHP")
			local RenewingMistHP = A.GetToggle(2, "RenewingMistHP")
			local EnvelopingMistHP = A.GetToggle(2, "EnvelopingMistHP")
			local ExpelHarmHP = A.GetToggle(2, "ExpelHarmHP")			
			local EssenceFontHP = A.GetToggle(2, "EssenceFontHP")
			local EssenceFontTargets = A.GetToggle(2, "EssenceFontTargets")
			local RefreshingJadeWindHP = A.GetToggle(2, "RefreshingJadeWindHP")
			local RefreshingJadeWindTargets = A.GetToggle(2, "RefreshingJadeWindTargets")							
			local BlanketRenewingMist = A.GetToggle(2, "BlanketRenewingMist")
			local Cleanse = A.GetToggle(2, "Cleanse")
			
			local SoothingMistActive = Unit(unitID):HasBuffs(A.SoothingMist.ID, true) > 0
			local InstantVivifyReady = Unit(player):HasBuffs(A.VivaciousVivification.ID) > 0 or SoothingMistActive
			local RenewingMistCount = HealingEngine:GetBuffsCount(A.RenewingMist.ID, A.Vivify:GetSpellCastTime(), player)

			local DungeonGroup = TeamCache.Friendly.Size >= 2 and TeamCache.Friendly.Size <= 5
			local RaidGroup = TeamCache.Friendly.Size >= 5 	
			
			local StandingOnFaeline = ((Unit(player):HasBuffs(A.AncientConcordance.ID) > 0 and A.AncientConcordance:IsTalentLearned()) or not A.AncientConcordance:IsTalentLearned())
			
			local getmembersAll = HealingEngine.GetMembersAll()			
			if Player:IsChanneling() == A.SoothingMist:Info() then
				for i = 1, #getmembersAll do 
					if Unit(getmembersAll[i].Unit):HasBuffs(A.SoothingMist.ID, true) > 0 and (Unit(getmembersAll[i].Unit):HealthPercent() > 90 or UnitGUID(getmembersAll[i].Unit) ~= UnitGUID(unitID)) then  
						return A:Show(icon, ACTION_CONST_STOPCAST)				                									
					end				
				end
			end
			
			local EmergencyHeals = EmergencyHealing(unitID)
			if EmergencyHeals then
				return EmergencyHeals:Show(icon)
			end
			
			local UseAoECDs = AoECDs()
			if UseAoECDs then
				return UseAoECDs:Show(icon)
			end
			
			if A.Detox:IsReady(unitID) and Cleanse and AuraIsValid(unitID, "UseDispel", "Dispel") then
				return A.Detox:Show(icon)
			end

			if A.ExpelHarm:IsReady(unitID, nil, nil, true) and not isMoving and Player:IsChanneling() == A.SoothingMist:Info() then
				if ExpelHarmHP >= 100 then
					if Unit(unitID):HealthDeficit() >= HealCalc(A.ExpelHarm) and Unit(player):HealthDeficit() >= HealCalc(A.ExpelHarm) then
						return A.ExpelHarm:Show(icon)
					end
				elseif ExpelHarmHP <= 99 then
					if Unit(unitID):HealthPercent() <= ExpelHarmHP and Unit(player):HealthPercent() <= ExpelHarmHP then
						return A.ExpelHarm:Show(icon)
					end
				end
			end

			if A.EnvelopingMist:IsReady(unitID, nil, nil, true) and not isMoving and Unit(unitID):HasBuffs(A.EnvelopingMist.ID, true) == 0 then
				if EnvelopingMistHP >= 100 then
					if Unit(unitID):HealthPercent() <= 50 or Unit(player):HasBuffs(A.YulonsBlessing.ID) > 0 or Unit(player):HasBuffsStacks(A.ChiJisBlessing.ID) >= 3 then
						if A.ManaTea:IsReady(player) then
							return A.ManaTea:Show(icon)
						end
						if A.SoothingMist:IsReady(unitID) then
							return A.SoothingMist:Show(icon)
						end
						if SoothingMistActive then
							return A.EnvelopingMist:Show(icon)
						end
					end
				elseif EnvelopingMistHP <= 99 then
					if Unit(unitID):HealthPercent() <= EnvelopingMistHP or Unit(player):HasBuffs(A.YulonsBlessing.ID) > 0 or Unit(player):HasBuffsStacks(A.ChiJisBlessing.ID) >= 3 then
						if A.ManaTea:IsReady(player) then
							return A.ManaTea:Show(icon)
						end						
						if A.SoothingMist:IsReady(unitID) then
							return A.SoothingMist:Show(icon)
						end
						if SoothingMistActive then
							return A.EnvelopingMist:Show(icon)
						end
					end
				end
			end 
			
			if RaidGroup then
				if A.FaelineStomp:IsReady(player) and not isMoving and MultiUnits:GetByRange(2, 10) >= 1 and not StandingOnFaeline then
					return A.FaelineStomp:Show(icon)
				end
				
				if A.Vivify:IsReady(unitID, nil, nil, true) and RenewingMistCount >= 12 and A.InvigoratingMists:IsTalentLearned() then
					if VivifyHP >= 100 then
						if Unit(unitID):HealthDeficit() >= HealCalc(A.Vivify) then
							if A.ManaTea:IsReady(player) and not A.InvokeYulon:IsTalentLearned() then
								return A.ManaTea:Show(icon)
							end						
							if A.SoothingMist:IsReady(unitID) and not InstantVivifyReady and not SoothingMistActive and not isMoving then
								return A.SoothingMist:Show(icon)
							end	
							if InstantVivifyReady then
								return A.Vivify:Show(icon)
							end
						end
					elseif VivifyHP <= 99 then
						if Unit(unitID):HealthPercent() <= VivifyHP then
							if A.ManaTea:IsReady(player) and not A.InvokeYulon:IsTalentLearned() then
								return A.ManaTea:Show(icon)
							end						
							if A.SoothingMist:IsReady(unitID) and not InstantVivifyReady and not SoothingMistActive and not isMoving then
								return A.SoothingMist:Show(icon)
							end		
							if InstantVivifyReady then
								return A.Vivify:Show(icon)
							end
						end
					end
				end
				
				if A.EssenceFont:IsReady(player) then
					if EssenceFontHP >= 100 then
						if HealingEngine.GetBelowHealthPercentUnits(90, 30) >= EssenceFontTargets then
							if A.BonedustBrew:IsReady(player) then
								return A.BonedustBrew:Show(icon)
							end
							if A.ThunderFocusTea:IsReady(player) and not A.RisingMist:IsTalentLearned() then
								return A.ThunderFocusTea:Show(icon)
							end
							return A.EssenceFont:Show(icon)
						end
					elseif EssenceFontHP <= 99 then 
						local EssenceFontHealingAmount = EssenceFontHP
						if HealingEngine.GetBelowHealthPercentUnits(EssenceFontHealingAmount, 30) >= EssenceFontTargets then
							if A.BonedustBrew:IsReady(player) then
								return A.BonedustBrew:Show(icon)
							end						
							if A.ThunderFocusTea:IsReady(player) and not A.RisingMist:IsTalentLearned() then
								return A.ThunderFocusTea:Show(icon)
							end
							return A.EssenceFont:Show(icon)
						end
					end
				end
				
				if ((A.RisingSunKick:IsReady(target) and A.IsUnitEnemy(target)) or (A.RisingSunKick:IsReady(targettarget) and A.IsUnitEnemy(targettarget))) and HealingEngine:GetBuffsCount(A.EssenceFont.ID, 0, player) >= 1 then
					if A.ThunderFocusTea:IsReady(player) and A.RisingMist:IsTalentLearned() then
						return A.ThunderFocusTea:Show(icon)
					end				
					return A.RisingSunKick:Show(icon)
				end

				if A.RefreshingJadeWind:IsReady(player) then
					if RefreshingJadeWindHP >= 100 then
						if HealingEngine.GetBelowHealthPercentUnits(85, 10) >= RefreshingJadeWindTargets then
							return A.RefreshingJadeWind:Show(icon)
						end
					elseif RefreshingJadeWindHP <= 99 then
						local RFJHealingAmount = RefreshingJadeWindHP
						if HealingEngine.GetBelowHealthPercentUnits(RFJHealingAmount, 10) >= RefreshingJadeWindTargets then
							return A.RefreshingJadeWind:Show(icon)
						end
					end
				end			
				
				if A.Vivify:IsReady(unitID, nil, nil, true) then
					if VivifyHP >= 100 then
						if Unit(unitID):HealthDeficit() >= HealCalc(A.Vivify) then
							if A.ManaTea:IsReady(player) and not A.InvokeYulon:IsTalentLearned() then
								return A.ManaTea:Show(icon)
							end
							if A.SoothingMist:IsReady(unitID) and not InstantVivifyReady and not SoothingMistActive and not isMoving then
								return A.SoothingMist:Show(icon)
							end
							if InstantVivifyReady then
								return A.Vivify:Show(icon)
							end
						end
					elseif VivifyHP <= 99 then
						if Unit(unitID):HealthPercent() <= VivifyHP then
							if A.ManaTea:IsReady(player) and not A.InvokeYulon:IsTalentLearned() then
								return A.ManaTea:Show(icon)
							end						
							if A.SoothingMist:IsReady(unitID) and not InstantVivifyReady and not SoothingMistActive then
								return A.SoothingMist:Show(icon)
							end
							if InstantVivifyReady then
								return A.Vivify:Show(icon)
							end
						end
					end
				end
				
				if A.ChiBurst:IsReady(player) and not isMoving then
					return A.ChiBurst:Show(icon)
				end

				if A.RenewingMist:IsReady(unitID) and Unit(unitID):HasBuffs(A.RenewingMist.ID, true) == 0 then
					local RenewingMistHealingAmount = 95
					if RenewingMistHP >= 100 then
						if Unit(unitID):HealthPercent() <= RenewingMistHealingAmount or A.RenewingMist:GetSpellCharges() >= 2 or BlanketRenewingMist then
							return A.RenewingMist:Show(icon)
						end
					elseif RenewingMistHP <= 99 then
						if Unit(unitID):HealthPercent() <= RenewingMistHP or A.RenewingMist:GetSpellCharges() >= 2 or BlanketRenewingMist then
							return A.RenewingMist:Show(icon)
						end
					end
				end				
			end
		
			if not RaidGroup then

				if A.RenewingMist:IsReady(unitID) and Unit(unitID):HasBuffs(A.RenewingMist.ID, true) == 0 then
					local RenewingMistHealingAmount = 95
					if RenewingMistHP >= 100 then
						if Unit(unitID):HealthPercent() <= RenewingMistHealingAmount or A.RenewingMist:GetSpellCharges() >= 2 or BlanketRenewingMist then
							return A.RenewingMist:Show(icon)
						end
					elseif RenewingMistHP <= 99 then
						if Unit(unitID):HealthPercent() <= RenewingMistHP or A.RenewingMist:GetSpellCharges() >= 2 or BlanketRenewingMist then
							return A.RenewingMist:Show(icon)
						end
					end
				end	

				if A.ZenPulse:IsReady(unitID) and Unit(unitID):IsMelee() and Unit(unitID):HealthPercent() <= 80 and inCombat then
					return A.ZenPulse:Show(icon)
				end
			
				if A.FaelineStomp:IsReady(player) and not isMoving and MultiUnits:GetByRange(2, 10) >= 1 then
					return A.FaelineStomp:Show(icon)
				end			

				if A.RefreshingJadeWind:IsReady(player) then
					if RefreshingJadeWindHP >= 100 then
						if HealingEngine.GetBelowHealthPercentUnits(85, 10) >= RefreshingJadeWindTargets then
							return A.RefreshingJadeWind:Show(icon)
						end
					elseif RefreshingJadeWindHP <= 99 then
						local RFJHealingAmount = RefreshingJadeWindHP
						if HealingEngine.GetBelowHealthPercentUnits(RFJHealingAmount, 10) >= RefreshingJadeWindTargets then
							return A.RefreshingJadeWind:Show(icon)
						end
					end
				end		
			
				if A.EssenceFont:IsReady(player) then
					if EssenceFontHP >= 100 then
						if HealingEngine.GetBelowHealthPercentUnits(90, 30) >= EssenceFontTargets then
							if A.BonedustBrew:IsReady(player) then
								return A.BonedustBrew:Show(icon)
							end						
							if A.ThunderFocusTea:IsReady(player) and not A.RisingMist:IsTalentLearned() then
								return A.ThunderFocusTea:Show(icon)
							end
							return A.EssenceFont:Show(icon)
						end
					elseif EssenceFontHP <= 99 then 
						local EssenceFontHealingAmount = EssenceFontHP
						if HealingEngine.GetBelowHealthPercentUnits(EssenceFontHealingAmount, 30) >= EssenceFontTargets then
							if A.BonedustBrew:IsReady(player) then
								return A.BonedustBrew:Show(icon)
							end						
							if A.ThunderFocusTea:IsReady(player) and not A.RisingMist:IsTalentLearned() then
								return A.ThunderFocusTea:Show(icon)
							end
							return A.EssenceFont:Show(icon)
						end
					end
				end
				
				if A.Vivify:IsReady(unitID, nil, nil, true) and SoothingMistActive then
					return A.Vivify:Show(icon)
				end

				if A.Vivify:IsReady(unitID, nil, nil, true) then
					if VivifyHP >= 100 then
						if Unit(unitID):HealthDeficit() >= HealCalc(A.Vivify) then
							if A.ManaTea:IsReady(player) and not A.InvokeYulon:IsTalentLearned() then
								return A.ManaTea:Show(icon)
							end						
							if A.SoothingMist:IsReady(unitID) and not InstantVivifyReady and not SoothingMistActive and not isMoving then
								return A.SoothingMist:Show(icon)
							end
							if InstantVivifyReady then
								return A.Vivify:Show(icon)
							end
						end
					elseif VivifyHP <= 99 then
						if Unit(unitID):HealthPercent() <= VivifyHP then
							if A.ManaTea:IsReady(player) and not A.InvokeYulon:IsTalentLearned() then
								return A.ManaTea:Show(icon)
							end						
							if A.SoothingMist:IsReady(unitID) and not InstantVivifyReady and not SoothingMistActive then
								return A.SoothingMist:Show(icon)
							end
							if InstantVivifyReady then
								return A.Vivify:Show(icon)
							end
						end
					end
				end				
				
				if A.FaelineStomp:IsReady(player) and Unit(player):HasBuffs(A.AncientTeachings.ID) == 0 and A.AncientTeachings:IsTalentLearned() and inCombat and not isMoving then
					return A.FaelineStomp:Show(icon)
				end
				
				if A.EssenceFont:IsReady(player) and Unit(player):HasBuffs(A.AncientTeachings.ID) == 0 and A.AncientTeachings:IsTalentLearned() and inCombat then
					return A.EssenceFont:Show(icon)
				end
				
			end
		
		end

    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    if IsUnitFriendly(target) then 
        unitID = target 
        
        if HealingRotation(unitID) then 
            return true 
        end 
    elseif IsUnitFriendly(focus) then	
		unitID = focus
		
		if HealingRotation(unitID) then
			return true
		end
	end  
    if A.IsUnitEnemy("target") then 
        unitID = "target"
        if EnemyRotation(unitID) then 
            return true
        end 
    end
end

A[1] = nil

A[4] = nil

A[5] = nil

A[6] = nil

A[7] = nil

A[8] = nil