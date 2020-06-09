table 50100 DateDropDown
{
    DataClassification = SystemMetadata;
    fields
    {
        field(1; "Period No."; Integer)
        {
            CaptionML=DEU='Periodennr.',ENU='Period No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Period Name"; Text[31])
        {
            CaptionML=DEU='Kennung',ENU='Identifier';
            DataClassification = ToBeClassified;
        }
        field(3; "Period Start"; Date)
        { 
            CaptionML=DEU='Start',ENU='Start';
        }
        field(4; "Period End"; Date)
        {
            CaptionML=DEU='Ende',ENU='End';
        }
    }

    keys
    {
        key("PK"; "Period No.")
        {
            Clustered = true;
        }
        // required for dropdown filtering oninput
        key("PeriodName";"Period Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Period Name","Period Start","Period End")
        {
        }
    }

}
