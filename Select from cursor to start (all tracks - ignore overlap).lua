--[[

With this you can select all items that is on the Right side of the edit cursor, on selected tracks. All overlapping items are ignored. There's also a script for selecting items on the left side.

By Bjorn Lohmander. This script is based on a Select all items on track by X-Rayman.
https://github.com/X-Raym/REAPER-ReaScripts/blob/068f211311df15266c91b4c3dfdd20e5d3792344/Items%20Properties/X-Raym_Add%20all%20items%20on%20selected%20track%20into%20item%20selection.lua
X-Rayman's Forum Thread: http://forum.cockos.com/showthread.php?p=1489411

--]]

function selected_items_on_tracks() -- local (i, j, item, take, track)


reaper.SelectAllMediaItems( 0, 0 )

  reaper.Undo_BeginBlock() -- Begining of the undo block. Leave it at the top of your main function.

  -- LOOP TRHOUGH SELECTED TRACKS
  
  selected_tracks_count = reaper.CountTracks(0)

  for i = 0, selected_tracks_count-1  do
    -- GET THE TRACK
    track_sel = reaper.GetTrack(0, i) -- Get selected track i

    item_num = reaper.CountTrackMediaItems(track_sel)

    -- ACTIONS
    for j = 0, item_num-1 do
    
    
     
      item = reaper.GetTrackMediaItem(track_sel, j)
      
      cursorPos= reaper.GetCursorPosition()
      
      itemPosStart = reaper.GetMediaItemInfo_Value( item, "D_POSITION" )
      itemLenght =  reaper.GetMediaItemInfo_Value( item, "D_LENGTH" )
      itemPosEnd=itemPosStart+itemLenght
      
      if itemPosStart>=cursorPos then
      
      reaper.SetMediaItemSelected(item, 1)
   end

    
    end

  end -- ENDLOOP through selected tracks
  

  reaper.Undo_EndBlock("Select all items on selected tracks", 0) -- End of the undo block. Leave it at the bottom of your main function.

end

selected_items_on_tracks() -- Execute your main function

reaper.UpdateArrange() -- Update the arrangement (often needed)
