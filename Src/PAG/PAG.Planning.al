page 50100 "Planning"
{

    PageType = Card;
    CaptionML = DEU = 'Einplanung', ENU = 'Planning';
    SourceTable = "Activities Cue"; // any table with multiple DateFilter fields 
    SourceTableTemporary = true;   

    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML=DEU='Allgemein',ENU='General';
                grid(Period)
                {
                    Caption = '';
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(FromRow)
                    {
                        CaptionML = DEU = 'Von', ENU = 'From';
                        field(FromWeek; FromWeek)
                        {
                            CaptionML = DEU = 'KW', ENU = 'Year';
                            TableRelation = DateDropDown."Period No." where("Period Start"=field("Due Date Filter"));
                            LookupPageId = DateDropDown;
                            ShowMandatory = true;
                            trigger OnValidate();
                            begin
                                if (FromWeek < ToWeek) then
                                    ToWeek := FromWeek;
                                UpdateTableRelationDateFilter();
                            end;
                        }
                        field(FromYear; FromYear)
                        {
                            CaptionML = DEU = 'Jahr', ENU = 'Year';
                            ShowMandatory = true;
                            trigger OnValidate();
                            begin
                                UpdateTableRelationDateFilter();
                            end;
                        }
                    }
                    group(ToRow)
                    {
                        CaptionML = DEU = 'Bis', ENU = 'To';
                        field(ToWeek; ToWeek)
                        {
                            ShowCaption = false;
                            CaptionML = DEU = 'Kalenderwoche Ende', ENU = 'Calendar Week End';
                            ShowMandatory = true;
                            TableRelation = DateDropDown."Period No." where("Period Start"=field("Due Next Week Filter"));
                            LookupPageId = DateDropDown;
                            trigger OnValidate();
                            begin
                                UpdateTableRelationDateFilter();
                            end;
                        }
                        field(ToYear; ToYear)
                        {
                            ShowCaption = false;
                            ShowMandatory = true;
                            trigger OnValidate();
                            begin
                                UpdateTableRelationDateFilter();
                            end;
                        }
                    }
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        // Current year as default
        FromYear := Date2DMY(Today, 3);
        ToYear := Date2DMY(Today, 3);     
        Rec.Insert(false);
        UpdateTableRelationDateFilter();
    end;


    trigger OnAfterGetRecord();
    begin
        UpdateTableRelationDateFilter();
    end;

    procedure UpdateTableRelationDateFilter()
    begin
        rec.setfilter("Due Date Filter",StrSubstNo('%1..%2',DMY2Date(1,1,FromYear),DMY2Date(31,12,FromYear)));
        rec.SetFilter("Due Next Week Filter",StrSubstNo('%1..%2',DMY2Date(1,1,ToYear),DMY2Date(31,12,ToYear)));
    end;

    var
        [InDataSet]
        FromWeek: Integer;
        [InDataSet]
        ToWeek: Integer;
        [InDataSet]
        FromYear: Integer;
        [InDataSet]
        ToYear: Integer;

}
