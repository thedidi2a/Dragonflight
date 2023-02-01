--#####################################
--##### TRIP'S DEMONOLOGY WARLOCK #####
--#####################################

local _G, setmetatable							= _G, setmetatable
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

Action[ACTION_CONST_WARLOCK_DEMONOLOGY] = {
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

    EyeofKilrogg   = Action.Create({ Type = "Spell", ID = 126 }),
    Corruption     = Action.Create({ Type = "Spell", ID = 172 }),
    Immolate       = Action.Create({ Type = "Spell", ID = 348 }),
    ShadowBolt     = Action.Create({ Type = "Spell", ID = 686 }),
    SummonImp= Action.Create({ Type = "Spell", ID = 688, Texture = 111859 }),
    SummonFelhunter= Action.Create({ Type = "Spell", ID = 691 }),
    SummonVoidwalker= Action.Create({ Type = "Spell", ID = 697 }),
    RitualofSummoning= Action.Create({ Type = "Spell", ID = 698 }),
    CurseofWeakness= Action.Create({ Type = "Spell", ID = 702 }),
    HealthFunnel   = Action.Create({ Type = "Spell", ID = 755 }),
    Agony          = Action.Create({ Type = "Spell", ID = 980 }),
    SubjugateDemon = Action.Create({ Type = "Spell", ID = 1098 }),
    Firebolt= Action.Create({ Type = "Spell", ID = 3110 }),
    ConsumingShadows= Action.Create({ Type = "Spell", ID = 3716 }),
    Fear           = Action.Create({ Type = "Spell", ID = 5782 }),
    CreateHealthstone= Action.Create({ Type = "Spell", ID = 6201 }),
    Seduction= Action.Create({ Type = "Spell", ID = 6358 }),
    Whiplash= Action.Create({ Type = "Spell", ID = 6360 }),
    LashofPain= Action.Create({ Type = "Spell", ID = 7814 }),
    LesserInvisibility= Action.Create({ Type = "Spell", ID = 7870 }),
    Suffering= Action.Create({ Type = "Spell", ID = 17735 }),
    ShadowBulwark= Action.Create({ Type = "Spell", ID = 17767 }),
    Immolation     = Action.Create({ Type = "Spell", ID = 19483 }),
    DevourMagic= Action.Create({ Type = "Spell", ID = 19505 }),
    SpellLock= Action.Create({ Type = "Spell", ID = 19647 }),
    SpellLockSac= Action.Create({ Type = "Spell", ID = 132409 }),
    Soulstone      = Action.Create({ Type = "Spell", ID = 20707 }),
    Incinerate     = Action.Create({ Type = "Spell", ID = 29722 }),
    SummonFelguard= Action.Create({ Type = "Spell", ID = 30146 }),
    Pursuit= Action.Create({ Type = "Spell", ID = 30151 }),
    LegionStrike= Action.Create({ Type = "Spell", ID = 30213 }),
    ShadowBite= Action.Create({ Type = "Spell", ID = 54049 }),
    DoomBolt       = Action.Create({ Type = "Spell", ID = 85692 }),
    Felstorm= Action.Create({ Type = "Spell", ID = 89751 }),
    AxeToss= Action.Create({ Type = "Spell", ID = 89766 }),
    Flee= Action.Create({ Type = "Spell", ID = 89792 }),
    SingeMagic= Action.Create({ Type = "Spell", ID = 89808 }),
    UnendingResolve= Action.Create({ Type = "Spell", ID = 104773 }),
    HandofGuldan   = Action.Create({ Type = "Spell", ID = 105174 }),
    ThreateningPresence= Action.Create({ Type = "Spell", ID = 112042 }),
    CommandDemon   = Action.Create({ Type = "Spell", ID = 119898 }),
    Cripple        = Action.Create({ Type = "Spell", ID = 170995 }),
    BurningPresence= Action.Create({ Type = "Spell", ID = 171011 }),
    Seethe= Action.Create({ Type = "Spell", ID = 171014 }),
    MeteorStrike   = Action.Create({ Type = "Spell", ID = 171017 }),
    TorchMagic= Action.Create({ Type = "Spell", ID = 171021 }),
    ShadowLock= Action.Create({ Type = "Spell", ID = 171138 }),
    DrainLife      = Action.Create({ Type = "Spell", ID = 234153 }),
    RitualofDoom   = Action.Create({ Type = "Spell", ID = 342601 }),
    SummonSayaad   = Action.Create({ Type = "Spell", ID = 366222 }),
    Doom           = Action.Create({ Type = "Spell", ID = 603 }),
    Banish         = Action.Create({ Type = "Spell", ID = 710 }),
    SummonInfernal= Action.Create({ Type = "Spell", ID = 1122 }),
    HowlofTerror   = Action.Create({ Type = "Spell", ID = 5484 }),
    RainofFire     = Action.Create({ Type = "Spell", ID = 5740 }),
    SoulFire       = Action.Create({ Type = "Spell", ID = 6353 }),
    MortalCoil     = Action.Create({ Type = "Spell", ID = 6789 }),
    Shadowburn     = Action.Create({ Type = "Spell", ID = 17877 }),
    Conflagrate    = Action.Create({ Type = "Spell", ID = 17962 }),
    ConflagrateDebuff    = Action.Create({ Type = "Spell", ID = 265931 }),
    SeedofCorruption= Action.Create({ Type = "Spell", ID = 27243 }),
    Shadowfury     = Action.Create({ Type = "Spell", ID = 30283 }),
    ShadowEmbrace  = Action.Create({ Type = "Spell", ID = 32388 }),
    Haunt          = Action.Create({ Type = "Spell", ID = 48181 }),
    SiphonLife     = Action.Create({ Type = "Spell", ID = 63106 }),
    Havoc          = Action.Create({ Type = "Spell", ID = 80240 }),
    CallDreadstalkers= Action.Create({ Type = "Spell", ID = 104316 }),
    SoulLink       = Action.Create({ Type = "Spell", ID = 108415 }),
    DarkPact       = Action.Create({ Type = "Spell", ID = 108416 }),
    GrimoireofSacrifice= Action.Create({ Type = "Spell", ID = 108503 }),
    Nightfall      = Action.Create({ Type = "Spell", ID = 108558 }),
    BurningRush    = Action.Create({ Type = "Spell", ID = 111400 }),
    DemonicGateway = Action.Create({ Type = "Spell", ID = 111771 }),
    GrimoireFelguard= Action.Create({ Type = "Spell", ID = 111898, Texture = 108503 }),
    ChaosBolt      = Action.Create({ Type = "Spell", ID = 116858 }),
    Cataclysm      = Action.Create({ Type = "Spell", ID = 152108 }),
    GrimoireofSynergy= Action.Create({ Type = "Spell", ID = 171975 }),
    WritheinAgony  = Action.Create({ Type = "Spell", ID = 196102 }),
    AbsoluteCorruption= Action.Create({ Type = "Spell", ID = 196103 }),
    SowtheSeeds    = Action.Create({ Type = "Spell", ID = 196226 }),
    Implosion      = Action.Create({ Type = "Spell", ID = 196277 }),
    Backdraft      = Action.Create({ Type = "Spell", ID = 196406 }),
    BackdraftBuff      = Action.Create({ Type = "Spell", ID = 117828 }),
    FireandBrimstone= Action.Create({ Type = "Spell", ID = 196408 }),
    Eradication    = Action.Create({ Type = "Spell", ID = 196412 }),
    EradicationDebuff    = Action.Create({ Type = "Spell", ID = 196414 }),
    ChannelDemonfire= Action.Create({ Type = "Spell", ID = 196447 }),
    SoulFlame      = Action.Create({ Type = "Spell", ID = 199471 }),
    HarvesterofSouls= Action.Create({ Type = "Spell", ID = 201424 }),
    DemonicCalling = Action.Create({ Type = "Spell", ID = 205145 }),
    ReverseEntropy = Action.Create({ Type = "Spell", ID = 205148 }),
    PhantomSingularity= Action.Create({ Type = "Spell", ID = 205179 }),
    SummonDarkglare= Action.Create({ Type = "Spell", ID = 205180 }),
    RoaringBlaze   = Action.Create({ Type = "Spell", ID = 205184 }),
    SoulConduit    = Action.Create({ Type = "Spell", ID = 215941 }),
    DemonSkin      = Action.Create({ Type = "Spell", ID = 219272 }),
    ImprovedConflagrate= Action.Create({ Type = "Spell", ID = 231793 }),
    CreepingDeath  = Action.Create({ Type = "Spell", ID = 264000 }),
    SoulStrike     = Action.Create({ Type = "Spell", ID = 264057 }),
    Dreadlash      = Action.Create({ Type = "Spell", ID = 264078 }),
    SummonVilefiend= Action.Create({ Type = "Spell", ID = 264119 }),
    PowerSiphon    = Action.Create({ Type = "Spell", ID = 264130 }),
    Demonbolt      = Action.Create({ Type = "Spell", ID = 264178 }),
    Darkfury       = Action.Create({ Type = "Spell", ID = 264874 }),
    SummonDemonicTyrant= Action.Create({ Type = "Spell", ID = 265187 }),
    RainofChaos    = Action.Create({ Type = "Spell", ID = 266086 }),
    RainofChaosBuff    = Action.Create({ Type = "Spell", ID = 266087 }),
    InternalCombustion= Action.Create({ Type = "Spell", ID = 266134 }),
    FromtheShadows = Action.Create({ Type = "Spell", ID = 267170 }),
    DemonicStrength= Action.Create({ Type = "Spell", ID = 267171 }),
    BilescourgeBombers= Action.Create({ Type = "Spell", ID = 267211 }),
    SacrificedSouls= Action.Create({ Type = "Spell", ID = 267214 }),
    InnerDemons    = Action.Create({ Type = "Spell", ID = 267216 }),
    NetherPortal   = Action.Create({ Type = "Spell", ID = 267217 }),
    NetherPortalBuff   = Action.Create({ Type = "Spell", ID = 267218 }),
    DemonicCircle  = Action.Create({ Type = "Spell", ID = 268358 }),
    Inferno        = Action.Create({ Type = "Spell", ID = 270545 }),
    VileTaint      = Action.Create({ Type = "Spell", ID = 278350 }),
    DemonicEmbrace = Action.Create({ Type = "Spell", ID = 288843 }),
    UnstableAffliction= Action.Create({ Type = "Spell", ID = 316099 }),
    XavianTeachings= Action.Create({ Type = "Spell", ID = 317031 }),
    StrengthofWill = Action.Create({ Type = "Spell", ID = 317138 }),
    MaleficRapture = Action.Create({ Type = "Spell", ID = 324536 }),
    AmplifyCurse   = Action.Create({ Type = "Spell", ID = 328774 }),
    FelDomination  = Action.Create({ Type = "Spell", ID = 333889 }),
    InevitableDemise= Action.Create({ Type = "Spell", ID = 334319 }),
    SoulboundTyrant= Action.Create({ Type = "Spell", ID = 334585 }),
    Shadowflame    = Action.Create({ Type = "Spell", ID = 384069 }),
    TeachingsoftheBlackHarvest= Action.Create({ Type = "Spell", ID = 385881 }),
    Soulburn       = Action.Create({ Type = "Spell", ID = 385899 }),
    CursesofEnfeeblement= Action.Create({ Type = "Spell", ID = 386105 }),
    FiendishStride = Action.Create({ Type = "Spell", ID = 386110 }),
    FelPact        = Action.Create({ Type = "Spell", ID = 386113 }),
    FelArmor       = Action.Create({ Type = "Spell", ID = 386124 }),
    AnnihilanTraining= Action.Create({ Type = "Spell", ID = 386174 }),
    DemonicKnowledge= Action.Create({ Type = "Spell", ID = 386185 }),
    CarnivorousStalkers= Action.Create({ Type = "Spell", ID = 386194 }),
    FelandSteel    = Action.Create({ Type = "Spell", ID = 386200 }),
    SummonSoulkeeper= Action.Create({ Type = "Spell", ID = 386244 }),
    InquisitorsGaze= Action.Create({ Type = "Spell", ID = 386344 }),
    AccruedVitality= Action.Create({ Type = "Spell", ID = 386613 }),
    DemonicFortitude= Action.Create({ Type = "Spell", ID = 386617 }),
    DesperatePact  = Action.Create({ Type = "Spell", ID = 386619 }),
    SweetSouls     = Action.Create({ Type = "Spell", ID = 386620 }),
    Lifeblood      = Action.Create({ Type = "Spell", ID = 386646 }),
    Nightmare      = Action.Create({ Type = "Spell", ID = 386648 }),
    GreaterBanish  = Action.Create({ Type = "Spell", ID = 386651 }),
    DarkAccord     = Action.Create({ Type = "Spell", ID = 386659 }),
    IchorofDevils  = Action.Create({ Type = "Spell", ID = 386664 }),
    FrequentDonor  = Action.Create({ Type = "Spell", ID = 386686 }),
    GrimFeast      = Action.Create({ Type = "Spell", ID = 386689 }),
    PandemicInvocation= Action.Create({ Type = "Spell", ID = 386759 }),
    Guillotine     = Action.Create({ Type = "Spell", ID = 386833 }),
    DemonicInspiration= Action.Create({ Type = "Spell", ID = 386858 }),
    WrathfulMinion = Action.Create({ Type = "Spell", ID = 386864 }),
    AgonizingCorruption= Action.Create({ Type = "Spell", ID = 386922 }),
    SoulSwap       = Action.Create({ Type = "Spell", ID = 386951 }),
    WitheringBolt  = Action.Create({ Type = "Spell", ID = 386976 }),
    SacrolashsDarkStrike= Action.Create({ Type = "Spell", ID = 386986 }),
    SoulRot= Action.Create({ Type = "Spell", ID = 386997 }),
    DarkHarvest    = Action.Create({ Type = "Spell", ID = 387016 }),
    WrathofConsumption= Action.Create({ Type = "Spell", ID = 387065 }),
    SoulTap        = Action.Create({ Type = "Spell", ID = 387073 }),
    TormentedCrescendo= Action.Create({ Type = "Spell", ID = 387075 }),
    GrandWarlocksDesign= Action.Create({ Type = "Spell", ID = 387084 }),
    ImprovedImmolate= Action.Create({ Type = "Spell", ID = 387093 }),
    Pyrogenics     = Action.Create({ Type = "Spell", ID = 387095 }),
    Ruin           = Action.Create({ Type = "Spell", ID = 387103 }),
    ConflagrationofChaos= Action.Create({ Type = "Spell", ID = 387108 }),
    BurntoAshes    = Action.Create({ Type = "Spell", ID = 387153 }),
    BurntoAshesBuff    = Action.Create({ Type = "Spell", ID = 387154 }),
    RitualofRuin   = Action.Create({ Type = "Spell", ID = 387156 }),
    RitualofRuinBuff   = Action.Create({ Type = "Spell", ID = 387157 }),
    AvatarofDestruction= Action.Create({ Type = "Spell", ID = 387159 }),
    MasterRitualist= Action.Create({ Type = "Spell", ID = 387165 }),
    RagingDemonfire= Action.Create({ Type = "Spell", ID = 387166 }),
    DiabolicEmbers = Action.Create({ Type = "Spell", ID = 387173 }),
    Decimation     = Action.Create({ Type = "Spell", ID = 387176 }),
    SeizedVitality = Action.Create({ Type = "Spell", ID = 387250 }),
    AshenRemains   = Action.Create({ Type = "Spell", ID = 387252 }),
    Flashpoint     = Action.Create({ Type = "Spell", ID = 387259 }),
    MalevolentVisionary= Action.Create({ Type = "Spell", ID = 387273 }),
    ChaosIncarnate = Action.Create({ Type = "Spell", ID = 387275 }),
    PowerOverwhelming= Action.Create({ Type = "Spell", ID = 387279 }),
    HauntedSoul    = Action.Create({ Type = "Spell", ID = 387301 }),
    ShadowsBite    = Action.Create({ Type = "Spell", ID = 387322 }),
    FelMight       = Action.Create({ Type = "Spell", ID = 387338 }),
    BloodboundImps = Action.Create({ Type = "Spell", ID = 387349 }),
    CrashingChaos  = Action.Create({ Type = "Spell", ID = 387355 }),
    Backlash       = Action.Create({ Type = "Spell", ID = 387384 }),
    DreadCalling   = Action.Create({ Type = "Spell", ID = 387391 }),
    DemonicMeteor  = Action.Create({ Type = "Spell", ID = 387396 }),
    FelSunder      = Action.Create({ Type = "Spell", ID = 387399 }),
    MadnessoftheAzjAqir= Action.Create({ Type = "Spell", ID = 387400 }),
    FelCovenant    = Action.Create({ Type = "Spell", ID = 387432 }),
    FelCovenantBuff    = Action.Create({ Type = "Spell", ID = 387437 }),
    ImpGangBoss    = Action.Create({ Type = "Spell", ID = 387445 }),
    InfernalBrand  = Action.Create({ Type = "Spell", ID = 387475 }),
    KazaaksFinalCurse= Action.Create({ Type = "Spell", ID = 387483 }),
    RippedthroughthePortal= Action.Create({ Type = "Spell", ID = 387485 }),
    HoundsofWar    = Action.Create({ Type = "Spell", ID = 387488 }),
    AntoranArmaments= Action.Create({ Type = "Spell", ID = 387494 }),
    Mayhem         = Action.Create({ Type = "Spell", ID = 387506 }),
    Pandemonium    = Action.Create({ Type = "Spell", ID = 387509 }),
    CryHavoc       = Action.Create({ Type = "Spell", ID = 387522 }),
    NerzhulsVolition= Action.Create({ Type = "Spell", ID = 387526 }),
    PactoftheImpMother= Action.Create({ Type = "Spell", ID = 387541 }),
    InfernalCommand= Action.Create({ Type = "Spell", ID = 387549 }),
    RollingHavoc   = Action.Create({ Type = "Spell", ID = 387569 }),
    GuldansAmbition= Action.Create({ Type = "Spell", ID = 387578 }),
    TheExpendables = Action.Create({ Type = "Spell", ID = 387600 }),
    StolenPower    = Action.Create({ Type = "Spell", ID = 387602 }),
    TeachingsoftheSatyr= Action.Create({ Type = "Spell", ID = 387972 }),
    DimensionalRift= Action.Create({ Type = "Spell", ID = 387976 }),
    DrainSoul      = Action.Create({ Type = "Spell", ID = 388667 }),
    ExplosivePotential= Action.Create({ Type = "Spell", ID = 388827 }),
    ScaldingFlames = Action.Create({ Type = "Spell", ID = 388832 }),
    ResoluteBarrier= Action.Create({ Type = "Spell", ID = 389359 }),
    FelSynergy     = Action.Create({ Type = "Spell", ID = 389367 }),
    ProfaneBargain = Action.Create({ Type = "Spell", ID = 389576 }),
    DemonicResilience= Action.Create({ Type = "Spell", ID = 389590 }),
    AbyssWalker    = Action.Create({ Type = "Spell", ID = 389609 }),
    GorefiendsResolve= Action.Create({ Type = "Spell", ID = 389623 }),
    SoulEatersGluttony= Action.Create({ Type = "Spell", ID = 389630 }),
    MaleficAffliction= Action.Create({ Type = "Spell", ID = 389761 }),
    DoomBlossom    = Action.Create({ Type = "Spell", ID = 389764 }),
    DreadTouch     = Action.Create({ Type = "Spell", ID = 389775 }),
    GrimReach      = Action.Create({ Type = "Spell", ID = 389992 }),
    ReignofTyranny = Action.Create({ Type = "Spell", ID = 390173 }),
    GrimoireofSacrificeBuff = Action.Create({ Type = "Spell", ID = 196099 }),     
    InquisitorsGazeBuff = Action.Create({ Type = "Spell", ID = 388068 }),   
    Blasphemy = Action.Create({ Type = "Spell", ID = 387161 }),   
    MadnessCB = Action.Create({ Type = "Spell", ID = 387409 }),   
    MadnessROF = Action.Create({ Type = "Spell", ID = 387413 }),  
    DemonicCore = Action.Create({ Type = "Spell", ID = 264173 }),  
    DemonicPower = Action.Create({ Type = "Spell", ID = 265273 }),  
    Healthstone     = Action.Create({ Type = "Item", ID = 5512 }),
}

local A = setmetatable(Action[ACTION_CONST_WARLOCK_DEMONOLOGY], { __index = Action })

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end
local player = "player"
local target = "target"
local pet = "pet"

Pet:AddActionsSpells(267, {
	A.LashofPain.ID,
	A.Whiplash.ID,
	A.ShadowBite.ID, 
}, true)

------------------------------------------
-------------- COMMON PREAPL -------------
------------------------------------------
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
    ImmolateDelay                           = 0,
    incomingAoEDamage                       = { 388537, --Arcane Fissue
                                                377004, --Deafening Screech
                                                388923, --Burst Forth
                                                212784, --Eye Storm
                                                192305, --Eye of the Storm (mini-boss)
                                                200901, --Eye of the Storm (boss)
                                                372863, --Ritual of Blazebinding
                                                153094, --Whispers of the Dark Star
                                                164974, --Dark Eclipse
                                                153804, --Inhale
                                                175988, --Omen of Death
                                                106228, --Nothingness
                                                374720, --Consuming Stomp
                                                384132, --Overwhelming Energy
                                                388008, --Absolute Zero
                                                385399, --Unleashed Destruction
                                                388817, --Shards of Stone
                                                387145, --Totemic Overload
    },
    scaryDebuffs                            = { 394917, --Leaping Flames
                                                391686, --Conductive Mark
    },
    curseOfTongues                          = {

    },
    curseofWeakness                         = {

    },
}

local function SelfDefensives()

    local defensiveActive = Unit(player):HasBuffs(A.DarkPact.ID) > 0 or Unit(player):HasBuffs(A.UnendingResolve.ID) > 0
    local isMoving = A.Player:IsMoving()

    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unitID
	if A.IsUnitEnemy("target") then 
        unitID = "target"
    end  

	if A.CanUseHealthstoneOrHealingPotion() then
        if A.Soulburn:IsReady(player) then
            return A.Soulburn
        end
		return A.Healthstone
	end

    if MultiUnits:GetByRangeCasting(60, 1, nil, Temp.incomingAoEDamage) >= 1 or Unit(player):HasDeBuffs(Temp.scaryDebuffs) > 0 and not defensiveActive then
        if A.DarkPact:IsReady(player) and Unit(player):HealthPercent() >= 50 then
            return A.DarkPact
        end
        if A.UnendingResolve:IsReady(player) then
            return A.UnendingResolve
        end
    end

    local UnendingResolveHP = A.GetToggle(2, "UnendingResolveHP")
    if A.UnendingResolve:IsReady(player) and Unit(player):HealthPercent() <= UnendingResolveHP then
        return A.UnendingResolve
    end

    local FelPactHP = A.GetToggle(2, "FelPactHP")
    if A.FelPact:IsReady(player) and Unit(player):HealthPercent() <= FelPactHP then
        return A.FelPact
    end

    local MortalCoilHP = A.GetToggle(2, "MortalCoilHP")
    if A.MortalCoil:IsReady(unitID) and Unit(player):HealthPercent() <= MortalCoilHP then
        return A.MortalCoil
    end

    local DrainLifeHP = A.GetToggle(2, "DrainLifeHP")
    if A.DrainLife:IsReady(unitID) and Unit(player):HealthPercent() <= DrainLifeHP and not isMoving then
        return A.DrainLife
    end

end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Interrupts spells
local function Interrupts(unitID)
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, true)
	
	if castRemainsTime >= A.GetLatency() then
        -- Silence
        if useKick and not notInterruptable and A.AxeToss:IsReady(unitID, nil, nil, true) then 
            return A.AxeToss
        end

        if useCC and A.MortalCoil:IsReady(unitID) and castRemainsTime > A.Banish:GetSpellCastTime() and not Unit(unitID):IsBoss() then 
            return A.MortalCoil
        end

        if useCC and A.Banish:IsReady(unitID) and castRemainsTime > A.Banish:GetSpellCastTime() and not Unit(unitID):IsBoss() and (Unit(unitID):CreatureType() == "Demon" or Unit(unitID):CreatureType() == "Aberration" or Unit(unitID):CreatureType() == "Elemental") then 
            return A.Banish
        end

        if useCC and A.Fear:IsReady(unitID) and castRemainsTime > A.Fear:GetSpellCastTime() and not Unit(unitID):IsBoss() then 
            return A.Fear
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

local function Purge(unitID)

    if A.DevourMagic:IsReady(unitID) and (AuraIsValid(unitID, "UsePurge", "PurgeHigh") or AuraIsValid(unitID, "UsePurge", "PurgeLow")) then 
		return A.DevourMagic
	end 

end

local function UseTrinkets(unitID)
	local TrinketType1 = A.GetToggle(2, "TrinketType1")
	local TrinketType2 = A.GetToggle(2, "TrinketType2")
	local TrinketValue1 = A.GetToggle(2, "TrinketValue1")
	local TrinketValue2 = A.GetToggle(2, "TrinketValue2")	

	if A.Trinket1:IsReady(unitID) then
		if TrinketType1 == "Damage" and Player:ManaPercentage() >= 20 then
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
		if TrinketType2 == "Damage" and Player:ManaPercentage() >= 20 then
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

local function HandlePetChoice()
    local petChoices = {
        IMP = A.SummonImp,
        VOIDWALKER = A.SummonVoidwalker,
        FELHUNTER = A.SummonFelhunter,
        SAYAAD = A.SummonSayaad,
        FELGUARD = A.SummonFelguard,
    }
    local choice = Action.GetToggle(2, "PetChoice")
    local currentSummon = petChoices[choice]
    if currentSummon:IsReady(player) then
        return currentSummon
    end
end

local function ActiveEnemies()

    local spells = {A.ShadowBite.ID, A.Whiplash.ID}
    local aoeDetection = A.GetToggle(2, "aoeDetection")

    for _, spell in pairs(spells) do
        if Pet:IsSpellKnown(spell) and aoeDetection == "Pet" then
            return Pet:GetInRange(spell)
            else return MultiUnits:GetActiveEnemies()
        end
    end

end

local function HavocTimer()

    local timer = 0
    local activeUnitPlates = MultiUnits:GetActiveUnitPlates()
	for namePlateUnitID in pairs(activeUnitPlates) do 
		if Unit(namePlateUnitID):HasDeBuffs(A.Havoc.ID, true) > 0 then
            timer = Unit(namePlateUnitID):HasDeBuffs(A.Havoc.ID, true)
        end
	end  

    return timer
end

local dontHavoc = {
    [59051] = true, -- Strife
    [59726] = true, -- Peril
}   

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local activeEnemies = ActiveEnemies()
    local useRacial = A.GetToggle(1, "Racial")
    local soulShards = Player:SoulShards()
    local havocRemains = HavocTimer()
    local TTD = MultiUnits.GetByRangeAreaTTD(40)
    local summonDemonicTyrantExpected = A.SummonDemonicTyrant:GetCooldown()
    local totemName = select(2, Player:GetTotemInfo(1))

    Player:AddTier("Tier29", { 200327, 200326, 200328, 200324, 200329, })
    local T29has2P = Player:HasTier("Tier29", 2)
    local T29has4P = Player:HasTier("Tier29", 4)

    -- actions.precombat+=/summon_pet
    local summonPet = HandlePetChoice()
    if summonPet and (not Unit(pet):IsExists() or Unit(pet):IsDead()) and Unit(player):HasBuffs(A.GrimoireofSacrificeBuff.ID) == 0 then
        if inCombat and A.FelDomination:IsReady(player) then
            return A.FelDomination:Show(icon)
        end
        if not isMoving or Unit(player):HasBuffs(A.FelDomination.ID) > 0 then
            return summonPet:Show(icon)
        end
    end

    local HealthFunnelHP = A.GetToggle(2, "HealthFunnelHP")
    if A.HealthFunnel:IsReady(player) and Unit(pet):HealthPercent() <= HealthFunnelHP and Unit(pet):IsExists() and not Unit(pet):IsDead() then
        return A.HealthFunnel:Show(icon)
    end

    local function EnemyRotation(unitID)

        local inRange = A.ShadowBolt:IsInRange(unitID)

        -- Defensive
        local SelfDefensive = SelfDefensives()
        if SelfDefensive then 
            return SelfDefensive:Show(icon)
        end 

        -- Interrupts
        local Interrupt = Interrupts(unitID)
        if Interrupt then 
            return Interrupt:Show(icon)
        end

		local DoPurge = Purge(unitID)
		if DoPurge then 
			return DoPurge:Show(icon)
		end	

        if Unit(unitID):IsExplosives() then
            if A.DrainLife:IsReady(unitID) then
                return A.DrainLife:Show(icon)
            end
        end

        -- actions.precombat+=/inquisitors_gaze
        if A.InquisitorsGaze:IsReady(player) and Unit(player):HasBuffs(A.InquisitorsGazeBuff.ID) == 0 then
            return A.InquisitorsGaze:Show(icon)
        end

        if not inCombat then
            -- actions.precombat+=/variable,name=tyrant_prep_start,op=set,value=12
            tyrantPrepStart = 12
            -- actions.precombat+=/variable,name=next_tyrant,op=set,value=14+talent.grimoire_felguard+talent.summon_vilefiend
            nextTyrant = 14 + num(A.GrimoireFelguard:IsTalentLearned()) + num(A.SummonVilefiend:IsTalentLearned())
            -- actions.precombat+=/power_siphon
            if A.PowerSiphon:IsReady(player) then
                return A.PowerSiphon:Show(icon)
            end
            -- actions.precombat+=/demonbolt,if=!buff.power_siphon.up
            if A.Demonbolt:IsReady(unitID) and Unit(player):HasBuffs(A.DemonicCore.ID) == 0 then
                return A.Demonbolt:Show(icon)
            end
            -- actions.precombat+=/shadow_bolt
            if A.ShadowBolt:IsReady(unitID) and not isMoving then
                return A.ShadowBolt:Show(icon)
            end
        end

        local function Tyrant()
            -- actions.tyrant=variable,name=next_tyrant,op=set,value=time+14+cooldown.grimoire_felguard.ready+cooldown.summon_vilefiend.ready,if=variable.next_tyrant<=time
            if nextTyrant <= combatTime then
                nextTyrant = combatTime + 14 + num(A.SummonVilefiend:IsReadyByPassCastGCD(player)) + num(A.GrimoireFelguard:IsReadyByPassCastGCD(unitID))
            end
            -- actions.tyrant+=/shadow_bolt,if=time<2&soul_shard<5
            if A.ShadowBolt:IsReady(unitID) and not isMoving and combatTime < 2 and soulShards < 5 then
                return A.ShadowBolt
            end
            -- actions.tyrant+=/nether_portal
            if A.NetherPortal:IsReady(player) and not isMoving then
                return A.NetherPortal
            end
            -- actions.tyrant+=/grimoire_felguard
            if A.GrimoireFelguard:IsReady(unitID) then
                return A.GrimoireFelguard
            end
            -- actions.tyrant+=/summon_vilefiend
            if A.SummonVilefiend:IsReady(player) and not isMoving then
                return A.SummonVilefiend
            end
            -- actions.tyrant+=/call_dreadstalkers
            if A.CallDreadstalkers:IsReady(unitID) and not isMoving then
                return A.CallDreadstalkers
            end
            -- actions.tyrant+=/soulburn,if=buff.nether_portal.up&soul_shard>=2,line_cd=40
            local function soulburn()
                if A.Soulburn:IsReady(unitID) and Unit(player):HasBuffs(A.NetherPortalBuff.ID) > 0 and soulShards >= 2 then
                    return A.Soulburn
                end
                C_Timer.After(40, soulburn)
            end
            soulburn()
            -- actions.tyrant+=/hand_of_guldan,if=variable.next_tyrant-time>2&(buff.nether_portal.up|soul_shard>2&variable.next_tyrant-time<12|soul_shard=5)
            if A.HandofGuldan:IsReady(unitID) then
                if nextTyrant - combatTime > 2 and (Unit(player):HasBuffs(A.NetherPortalBuff.ID) > 0 or soulShards > 2 and nextTyrant - combatTime < 12 or soulShards == 5) then
                    return A.HandofGuldan
                end
            end
            -- actions.tyrant+=/hand_of_guldan,if=talent.soulbound_tyrant&variable.next_tyrant-time<4&variable.next_tyrant-time>action.summon_demonic_tyrant.cast_time
            if A.HandofGuldan:IsReady(unitID) and not isMoving and A.SoulboundTyrant:IsTalentLearned() and nextTyrant - combatTime < 4 and nextTyrant - combatTime > A.SummonDemonicTyrant:GetSpellCastTime() then
                return A.HandofGuldan
            end
            -- actions.tyrant+=/summon_demonic_tyrant,if=variable.next_tyrant-time<cast_time*2
            if A.SummonDemonicTyrant:IsReady(player) and not isMoving and nextTyrant - combatTime < A.SummonDemonicTyrant:GetSpellCastTime() * 2 then
                return A.SummonDemonicTyrant
            end
            -- actions.tyrant+=/demonbolt,if=buff.demonic_core.up
            if A.Demonbolt:IsReady(unitID) and Unit(player):HasBuffs(A.DemonicCore.ID) > 0 then
                return A.Demonbolt
            end
            -- actions.tyrant+=/power_siphon,if=buff.wild_imps.stack>1&!buff.nether_portal.up
            if A.PowerSiphon:IsReady(player) and Unit(player):HasBuffs(A.NetherPortalBuff.ID) == 0 then
                return A.PowerSiphon
            end
            -- actions.tyrant+=/soul_strike
            if A.SoulStrike:IsReady(player) and Unit(pet):IsExists() and not Unit(pet):IsDead() then
                return A.SoulStrike
            end
            -- actions.tyrant+=/shadow_bolt
            if A.ShadowBolt:IsReady(unitID) and not isMoving then
                return A.ShadowBolt
            end
        end

        local useTyrant = Tyrant()
        -- # Executed every time the actor is available.
        -- actions=call_action_list,name=tyrant,if=talent.summon_demonic_tyrant&(time-variable.next_tyrant)<=(variable.tyrant_prep_start+2)&cooldown.summon_demonic_tyrant.up
        if inRange then
            if A.SummonDemonicTyrant:IsTalentLearned() and (combatTime - nextTyrant) <= (tyrantPrepStart + 2) and A.SummonDemonicTyrant:GetCooldown() == 0 then
                if useTyrant then
                    return useTyrant:Show(icon)
                end
            end
            -- actions+=/call_action_list,name=tyrant,if=talent.summon_demonic_tyrant&cooldown.summon_demonic_tyrant.remains_expected<=variable.tyrant_prep_start
            if A.SummonDemonicTyrant:IsTalentLearned() and BurstIsON(unitID) and summonDemonicTyrantExpected <= tyrantPrepStart then
                if useTyrant then
                    return useTyrant:Show(icon)
                end
            end
            -- actions+=/implosion,if=time_to_die<2*gcd
            if A.Implosion:IsReady(unitID) and TTD < 2 * A.GetGCD() then
                return A.Implosion:Show(icon)
            end
            -- actions+=/nether_portal,if=!talent.summon_demonic_tyrant&soul_shard>2|time_to_die<30
            if A.NetherPortal:IsReady(player) and not isMoving and BurstIsON(unitID) and (not A.SummonDemonicTyrant:IsTalentLearned() and soulShards > 2 or TTD < 30) then
                return A.NetherPortal:Show(icon)
            end
            -- actions+=/hand_of_guldan,if=buff.nether_portal.up
            if A.HandofGuldan:IsReady(unitID) and not isMoving and Unit(player):HasBuffs(A.NetherPortalBuff.ID) > A.HandofGuldan:GetSpellCastTime() then
                return A.HandofGuldan:Show(icon)
            end
            -- actions+=/call_action_list,name=items
            -- actions+=/call_action_list,name=ogcd,if=buff.demonic_power.up|!talent.summon_demonic_tyrant&(buff.nether_portal.up|!talent.nether_portal)

            if Unit(player):HasBuffs(A.DemonicPower.ID) > 0 or not A.SummonDemonicTyrant:IsTalentLearned() and (Unit(player):HasBuffs(A.NetherPortalBuff.ID) > 0 or not A.NetherPortal:IsTalentLearned()) then
                -- actions.ogcd=potion
                if useRacial then
                    -- actions.ogcd+=/berserking
                    if A.Berserking:IsReady(player) then
                        return A.Berserking:Show(icon)
                    end
                    -- actions.ogcd+=/blood_fury
                    if A.BloodFury:IsReady(player) then
                        return A.BloodFury:Show(icon)
                    end
                    -- actions.ogcd+=/fireblood
                    if A.Fireblood:IsReady(player) then
                        return A.Fireblood:Show(icon)
                    end
                end
            end

            -- actions+=/call_dreadstalkers,if=cooldown.summon_demonic_tyrant.remains_expected>cooldown
            if A.CallDreadstalkers:IsReady(unitID) and not isMoving and summonDemonicTyrantExpected > 20 then
                return A.CallDreadstalkers:Show(icon)
            end
            -- actions+=/call_dreadstalkers,if=!talent.summon_demonic_tyrant|time_to_die<14
            if A.CallDreadstalkers:IsReady(unitID) and not isMoving and (not A.SummonDemonicTyrant:IsTalentLearned() or TTD < 14) then
                return A.CallDreadstalkers:Show(icon)
            end
            -- actions+=/grimoire_felguard,if=!talent.summon_demonic_tyrant|time_to_die<cooldown.summon_demonic_tyrant.remains_expected
            if A.GrimoireFelguard:IsReady(unitID) and (not A.SummonDemonicTyrant:IsTalentLearned() or TTD < summonDemonicTyrantExpected) then
                return A.GrimoireFelguard:Show(icon)
            end
            -- actions+=/summon_vilefiend,if=!talent.summon_demonic_tyrant|cooldown.summon_demonic_tyrant.remains_expected>cooldown+variable.tyrant_prep_start|time_to_die<cooldown.summon_demonic_tyrant.remains_expected
            if A.SummonVilefiend:IsReady(player) and not isMoving then
                if not A.SummonDemonicTyrant:IsTalentLearned() or A.SummonDemonicTyrant:GetCooldown() > 1.2 + tyrantPrepStart or TTD < summonDemonicTyrantExpected > 45 + tyrantPrepStart or TTD < summonDemonicTyrantExpected then
                    return A.SummonVilefiend:Show(icon)
                end
            end
            -- actions+=/guillotine,if=cooldown.demonic_strength.remains
            if A.Guillotine:IsReady(player) and A.DemonicStrength:GetCooldown() > 0 then
                return A.Guillotine:Show(icon)
            end
            -- actions+=/demonic_strength
            if A.DemonicStrength:IsReady(player) and Unit(pet):IsExists() then
                return A.DemonicStrength:Show(icon)
            end
            -- actions+=/bilescourge_bombers,if=!pet.demonic_tyrant.active
            if A.BilescourgeBombers:IsReady(player) and Unit(player):HasBuffs(A.DemonicPower.ID) == 0 then
                return A.BilescourgeBombers:Show(icon)
            end
            -- actions+=/shadow_bolt,if=soul_shard<5&talent.fel_covenant&buff.fel_covenant.remains<5
            if A.ShadowBolt:IsReady(unitID) and not isMoving and soulShards < 5 and A.FelCovenant:IsTalentLearned() and Unit(player):HasBuffs(A.FelCovenantBuff.ID) < 5 then
                return A.ShadowBolt:Show(icon)
            end
            -- actions+=/implosion,if=two_cast_imps>0&buff.tyrant.down&active_enemies>1+(talent.sacrificed_souls.enabled)
            if A.Implosion:IsReady(unitID) and Unit(player):HasBuffs(A.DemonicPower.ID) == 0 and activeEnemies > (1 + num(A.SacrificedSouls:IsTalentLearned())) then
                return A.Implosion:Show(icon)
            end
            -- actions+=/implosion,if=buff.wild_imps.stack>9&buff.tyrant.up&active_enemies>2+(1*talent.sacrificed_souls.enabled)&cooldown.call_dreadstalkers.remains>17&talent.the_expendables
            if A.Implosion:IsReady(unitID) and A.Implosion:GetCount() > 9 and Unit(player):HasBuffs(A.DemonicPower.ID) > 0 and activeEnemies > 2 + (1 * num(A.SacrificedSouls:IsTalentLearned())) and A.CallDreadstalkers:GetCooldown() > 17 and A.TheExpendables:IsTalentLearned() then
                return A.Implosion:Show(icon)
            end
            -- actions+=/implosion,if=active_enemies=1&last_cast_imps>0&buff.tyrant.down&talent.imp_gang_boss.enabled&!talent.sacrificed_souls
            if A.Implosion:IsReady(unitID) and activeEnemies == 1 and Unit(player):HasBuffs(A.DemonicPower.ID) == 0 and A.ImpGangBoss:IsTalentLearned() and not A.SacrificedSouls:IsTalentLearned() then
                return A.Implosion:Show(icon)
            end
            -- actions+=/soul_strike,if=soul_shard<5&active_enemies>1
            if A.SoulStrike:IsReady(player) and Unit(pet):IsExists() and not Unit(pet):IsDead() and soulShards < 5 and activeEnemies > 1 then
                return A.SoulStrike:Show(icon)
            end
            -- actions+=/summon_soulkeeper,if=active_enemies>1&buff.tormented_soul.stack=10
            if A.SummonSoulkeeper:IsReady(player) and not isMoving and activeEnemies > 1 and A.SummonSoulkeeper:GetCount() == 10 then
                return A.SummonSoulkeeper:Show(icon)
            end
            -- actions+=/demonbolt,if=buff.demonic_core.up&soul_shard<4
            if A.Demonbolt:IsReady(unitID) and Unit(player):HasBuffs(A.DemonicCore.ID) > 0 and soulShards < 4 then
                return A.Demonbolt:Show(icon)
            end
            -- actions+=/power_siphon,if=buff.demonic_core.stack<1&(buff.dreadstalkers.remains>3|buff.dreadstalkers.down)
            if A.PowerSiphon:IsReady(player) and Unit(player):HasBuffs(A.DemonicCore.ID) < 1 and ((totemName == "Dreadstalker" and Player:GetTotemTimeLeft(1) > 3) or totemName ~= "Dreadstalker") then
                return A.PowerSiphon:Show(icon)
            end
            -- actions+=/hand_of_guldan,if=soul_shard>2&(!talent.summon_demonic_tyrant|cooldown.summon_demonic_tyrant.remains_expected>variable.tyrant_prep_start+2)
            if A.HandofGuldan:IsReady(unitID) and not isMoving and soulShards > 2 and (not A.SummonDemonicTyrant:IsTalentLearned() or summonDemonicTyrantExpected > tyrantPrepStart + 2 or soulShards == 5) then
                return A.HandofGuldan:Show(icon)
            end
            -- actions+=/doom,target_if=refreshable
            if A.Doom:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.Doom.ID, true) == 0  then
                return A.Doom:Show(icon)
            end
            -- actions+=/soul_strike,if=soul_shard<5
            if A.SoulStrike:IsReady(unitID) and soulShards < 5 and Unit(pet):IsExists() and not Unit(pet):IsDead() then
                return A.SoulStrike:Show(icon)
            end
            -- actions+=/shadow_bolt
            if A.ShadowBolt:IsReady(unitID) and not isMoving then
                return A.ShadowBolt:Show(icon)
            end

            if A.Demonbolt:IsReady(unitID) and Unit(player):HasBuffs(A.DemonicCore.ID) > 0 then
                return A.Demonbolt:Show(icon)
            end

        end

    end

    -- Target  
    if A.IsUnitEnemy("target") then 
        unitID = "target"
        if EnemyRotation(unitID) then 
            return true
        end 

    end
end
-- Finished

A[1] = nil

A[4] = nil

A[5] = nil

A[6] = nil

A[7] = nil

A[8] = nil