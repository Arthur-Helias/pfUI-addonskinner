pfUI.addonskinner:RegisterSkin("ModernMapMarkers", function()
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, SkinButton, SkinCheckbox, HookAddonOrVariable =
  penv.StripTextures, penv.CreateBackdrop, penv.SkinButton, penv.SkinCheckbox, penv.HookAddonOrVariable

  -- This function waits until the "ModernMapMarkers" addon is loaded,
  -- ensuring its frames exist before we try to skin them.
  HookAddonOrVariable("ModernMapMarkers", function()
    local configFrame = MMMConfigFrame
    if not configFrame or configFrame.skinned then return end

    -- Main Configuration Frame
    StripTextures(configFrame)
    CreateBackdrop(configFrame, nil, nil, .75)

    -- The checkboxes and close button are unnamed, so we must find them by iterating
    -- through the frame's children and identifying them by their properties.
    local children = {configFrame:GetChildren()}
    for i=1, table.getn(children) do
      local child = children[i]
      local objectType = child:GetObjectType()

      if objectType == "CheckButton" then
        SkinCheckbox(child)
      elseif objectType == "Button" and child:GetText() == "Close" then
        SkinButton(child)
      end
    end

    -- Mark the frame as skinned to prevent this code from running again
    configFrame.skinned = true
  end)
end)