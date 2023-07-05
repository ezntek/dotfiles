{ config }:
    let
      inherit (config.lib.formats.rasi) mkLiteral;
      literal_inherit = mkLiteral "inherit";
    in {
      "*" = {
        bg-col = mkLiteral "#1e1e2e";
        bg-col-light = mkLiteral "#1e1e2e";
        border-col = mkLiteral "#cba6f7";
        selected-col = mkLiteral "#1e1e2e";
        blue = mkLiteral "#cba6f7";
        fg-col = mkLiteral "#cdd6f4";
        fg-col-2 = mkLiteral "#cba6f7";
        grey = mkLiteral "#6c7086";

        width = 600;
        font = "Iosevka Dlig SS20 14";
      };

      "#element-text" = {
        background-color = literal_inherit;
        text-color =       literal_inherit;
      };

      "#element-icon" = {
          background-color = literal_inherit;
          text-color =       literal_inherit;
      };

      "#mode-switcher" = {
          background-color = literal_inherit;
          text-color =       literal_inherit;
      };

      "#window" = {
          height = mkLiteral "360px";
          border = mkLiteral "4px";
          border-color = mkLiteral "@border-col";
          background-color = mkLiteral "@bg-col";
          border-radius = mkLiteral "12px";
      };

      "#mainbox" = {
          background-color = mkLiteral "@bg-col";
      };

      "#inputbar" = {
          children = map mkLiteral [ "prompt" "entry" ];
          background-color = mkLiteral "@bg-col";
          border-radius = mkLiteral "5px";
          padding = mkLiteral "2px";
      };

      "#prompt" =  {
          background-color = mkLiteral "@blue";
          padding = mkLiteral "6px";
          text-color = mkLiteral "@bg-col";
          border-radius = mkLiteral "3px";
          margin = mkLiteral "20px 0px 0px 20px";
      };

      "#textbox-prompt-colon" = {
        expand = false;
        str = ":";
      };

      "#entry" = {
        padding = mkLiteral "6px";
        margin = mkLiteral "20px 0px 0px 10px";
        text-color = mkLiteral "@fg-col";
        background-color = mkLiteral "@bg-col";
      };

      "#listview" = {
        border = mkLiteral "0px 0px 0px";
        padding = mkLiteral "6px 0px 0px";
        margin = mkLiteral "10px 0px 0px 20px";
        columns = 2;
        lines = 5;
        background-color = mkLiteral "@bg-col";
      };

      "#element" = {
        padding = mkLiteral "5px";
        background-color = mkLiteral "@bg-col";
        text-color = mkLiteral "@fg-col"  ;
      };

      "#element-icon" = {
        size = mkLiteral "25px";
      };

      "#element selected" = {
        background-color =  mkLiteral "@selected-col" ;
        text-color = mkLiteral "@fg-col-2" ;
      };

      "#mode-switcher" = {
        spacing = 0;
      };

      "#button" = {
        padding = mkLiteral "10px";
        background-color = mkLiteral "@bg-col-light";
        text-color = mkLiteral "@grey";
        vertical-align = mkLiteral "0.5"; 
        horizontal-align = mkLiteral "0.5";
      };

      "#button selected" =  {
        background-color = mkLiteral "@bg-col";
        text-color = mkLiteral "@blue";
      };

      "#message" = {
        background-color = mkLiteral "@bg-col-light";
        margin = mkLiteral "2px";
        padding = mkLiteral "2px";
        border-radius = mkLiteral "5px";
      };

      "#textbox" =  {
        padding = mkLiteral "6px";
        margin = mkLiteral "20px 0px 0px 20px";
        text-color = mkLiteral "@blue";
        background-color = mkLiteral "@bg-col-light";
      };
    }
