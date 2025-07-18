--
-- DESCRIPTION
--
-- @COMPANY 
-- @AUTHOR 
-- @DATE 2025/07/13 00:13:13
--
require("LuaPanda").start("127.0.0.1",8818)

---@type B_BaseCharacter_C
local B_BaseCharacter_C = UnLua.Class()

local E_MovementType = UE.UObject.Load('/Game/SoulslikeFramework/Enums/E_MovementType.E_MovementType')

-- function B_BaseCharacter_C:Initialize(Initializer)
-- end

-- function B_BaseCharacter_C:UserConstructionScript()
-- end

-- function B_BaseCharacter_C:ReceiveBeginPlay()
-- end

-- function B_BaseCharacter_C:ReceiveEndPlay()
-- end

-- function B_BaseCharacter_C:ReceiveTick(DeltaSeconds)
-- end

-- function B_BaseCharacter_C:ReceiveAnyDamage(Damage, DamageType, InstigatedBy, DamageCauser)
-- end

-- function B_BaseCharacter_C:ReceiveActorBeginOverlap(OtherActor)
-- end

-- function B_BaseCharacter_C:ReceiveActorEndOverlap(OtherActor)
-- end

function B_BaseCharacter_C:SetMovementMode(Type)
    
    local FrostbiteTag = UE.FGameplayTag("SoulslikeFramework.StatusEffect.Frostbite")
    local WeightTag = UE.FGameplayTag("SoulslikeFramework.Stat.Misc.Weight")
    local Speed = 0
    if Type == E_MovementType.Run then 
        Speed = self.AC_StatManager.SpeedAsset.RunSpeed
    elseif Type == E_MovementType.Walk then 
        Speed = self.AC_StatManager.SpeedAsset.WalkSpeed
    else
        Speed = self.AC_StatManager.SpeedAsset.SprintSpeed
    end
    local StateInfo = UE.UObject.Load('/Game/SoulslikeFramework/Structures/Stats/FStatInfo.FStatInfo')
    self.AC_StatManager:GetStat(WeightTag , nil , StateInfo)
    if 1 - (StateInfo.CurrentValue / StateInfo.MaxValue) <= 0 then 
        Speed = Speed * 0.1
    end
    if not self.AC_StatusEffectManager:IsStatusEffectActive(FrostbiteTag) then 
        self:SetSpeedReplicated(Speed)
    end
end

function B_BaseCharacter_C:SetSpeedReplicated(NewSpeed)
    self:SetSpeed(NewSpeed)
end

return B_BaseCharacter_C
