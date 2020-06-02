page 50101 DateDropDown
{
    PageType = List;
    SourceTable = DateDropDown;
    SourceTableTemporary = true;
    LinksAllowed = false;
    CaptionML = DEU = 'Kalenderwochen', ENU = 'Calendar Weeks';

    layout
    {
        area(content)
        {
            repeater("List")
            {
                field("Period No."; "Period No.") { }
                field("Period Name"; "Period Name") {
                    CaptionML=DEU = 'KW', ENU = 'CW';
                 }
                field("Period Start"; "Period Start") { }
                field("Period End"; "Period End") { }

            }

        }
    }

    trigger OnOpenPage();
    begin
        LoadLines;
    end;
    procedure LoadLines(): Boolean;
    var
        DateRec: Record "Date";
        CurrView: text;  //debuginfo
        LineCount: Integer; // debuginfo
    begin
        //* Lädt die Liste der Daten die im LookUp angezeigt werden sollen
        IF IsListLoaded THEN exit(false);
        CurrView := GETVIEW(true);
        DateRec.SetRange("Period Type", DateRec."Period Type"::Week);
        DateRec.SetFilter("Period Start", GetFilter(Rec."Period Start"));
        IF not DateRec.FINDSET THEN
            exit;
        REPEAT
            TEMP_DateDropDown."Period No." := DateRec."Period No.";
            TEMP_DateDropDown."Period Start" := DateRec."Period Start";
            TEMP_DateDropDown."Period End" := DateRec."Period End";
            TEMP_DateDropDown."Period Name" :=Format(DateRec."Period Start",0,'<Week,2>/<Year>');
            TEMP_DateDropDown.INSERT;
        UNTIL DateRec.NEXT = 0;
        LineCount := TEMP_DateDropDown.Count;
        IsListLoaded := true;
        rec.Copy(TEMP_DateDropDown, true)
    end;


    var
        TEMP_DateDropDown: Record DateDropDown temporary;
        IsListLoaded: Boolean;
}