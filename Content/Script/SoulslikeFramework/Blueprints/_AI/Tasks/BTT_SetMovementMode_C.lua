--
-- DESCRIPTION
--
-- @COMPANY 
-- @AUTHOR 
-- @DATE 2025/07/18 17:21:16
--

---@type BTT_SetMovementMode_C
local BTT_SetMovementMode_C = UnLua.Class()

function BTT_SetMovementMode_C:ReceiveExecuteAI(OwnerController, ControlledPawn) 
    ControlledPawn:SetMovementMode(self.MovementMode)
    self:FinishExecute(true)
end

return BTT_SetMovementMode_C