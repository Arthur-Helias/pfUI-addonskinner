pfUI.addonskinner:RegisterSkin("MessageBox", function()
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, SkinButton, SkinCloseButton, SkinCheckbox, hooksecurefunc, SkinArrowButton =
  penv.StripTextures, penv.CreateBackdrop, penv.SkinButton, penv.SkinCloseButton, penv.SkinCheckbox, penv.hooksecurefunc, penv.SkinArrowButton

  hooksecurefunc(MessageBox, "ShowFrame", function(self)
    -- Check if the frame has already been skinned to prevent re-applying the skin
    if self.frame.skinned then return end

    -- Main Frame
    StripTextures(self.frame)
    CreateBackdrop(self.frame, nil, nil, .75)

    -- The close, delete, and delete all buttons are not named, so we find them by iterating
    local children = {self.frame:GetChildren()}
    for i=1, table.getn(children) do
      local child = children[i]
      if child:GetObjectType() == "Button" then
        -- The close button is unnamed, has no text, and is a specific size from its template
        if not child:GetText() and child:GetWidth() == 32 and child:GetHeight() == 32 then
          SkinCloseButton(child, self.frame.backdrop, -6, -6)
        elseif child:GetText() == "Delete" then
           SkinButton(child)
        elseif child:GetText() == "Delete All" then
           SkinButton(child)
        end
      end
    end

    -- Skin the custom-made collapsible headers' plus/minus buttons using SkinArrowButton
    if MessageBox.friendsHeader and MessageBox.friendsHeader.frame then
        StripTextures(MessageBox.friendsHeader.frame) -- Strip the highlight texture
        SkinArrowButton(MessageBox.friendsHeader.plusButton, "down", 16)
        SkinArrowButton(MessageBox.friendsHeader.minusButton, "up", 16)
    end

    if MessageBox.conversationsHeader and MessageBox.conversationsHeader.frame then
        StripTextures(MessageBox.conversationsHeader.frame) -- Strip the highlight texture
        SkinArrowButton(MessageBox.conversationsHeader.plusButton, "down", 16)
        SkinArrowButton(MessageBox.conversationsHeader.minusButton, "up", 16)
    end

    -- Contact Frame
    if MessageBoxContactScroll then
      StripTextures(MessageBoxContactScroll:GetParent())
      CreateBackdrop(MessageBoxContactScroll:GetParent(), nil, nil, .8)
    end

    -- Chat Frame
    if MessageBoxChatHistory then
        StripTextures(MessageBoxChatHistory:GetParent())
        CreateBackdrop(MessageBoxChatHistory:GetParent(), nil, nil, .8)

        -- The Send button is a child of the chat frame's parent
        if MessageBoxWhisperInput and MessageBoxWhisperInput:GetParent() then
            local chatChildren = {MessageBoxWhisperInput:GetParent():GetChildren()}
            for i=1, table.getn(chatChildren) do
                local child = chatChildren[i]
                if child:GetObjectType() == "Button" and child:GetText() == "Send" then
                    SkinButton(child)
                end
            end
        end
    end

    -- Checkbox
    if MessageBoxPopupCheckButton then
      SkinCheckbox(MessageBoxPopupCheckButton)
    end

    -- Mark as skinned to prevent re-skinning
    self.frame.skinned = true
  end)
end)