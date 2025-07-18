--
-- DESCRIPTION
--
-- @COBTT_ToggleFocus_CPANY 
-- @AUTHOR 
-- @DATE 2025/07/18 16:51:44
--

---@type BTT_ToggleFocus_C
local BTT_ToggleFocus_C = UnLua.Class()

local RotateDuration = 0.25
function BTT_ToggleFocus_C:ReceiveExecuteAI(OwnerController, ControlledPawn) 
    local FocusActor = OwnerController:GetFocusActor()
    if self.bFocus then 
        if FocusActor and FocusActor:IsValid() then 
            self:FinishExecute(true)
        else
            FocusActor = UE.UBTFunctionLibrary.GetBlackboardValueAsActor(self , self.TargetKey)
            OwnerController:K2_SetFocus(FocusActor)
            ControlledPawn:RotateTowardsTarget(RotateDuration)
            self:FinishExecute(true)
        end
    else
        if FocusActor and FocusActor:IsValid() then 
            OwnerController:K2_ClearFocus()
            self:FinishExecute(true)
        else
            self:FinishExecute(true)
        end
    end
end


return BTT_ToggleFocus_C