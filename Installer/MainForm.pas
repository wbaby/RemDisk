Unit MainForm;

Interface

Uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  AbstractInstallerPage;

Type
  TForm1 = Class (TForm)
    StepPanel: TPanel;
    PagesPageControl: TPageControl;
    ActionTabSheet: TTabSheet;
    SettingsTabSheet: TTabSheet;
    ProgressTabSheet: TTabSheet;
    SuccessTabSheet: TTabSheet;
    FailureTabSheet: TTabSheet;
    InitialTabSheet: TTabSheet;
    CancelButton: TButton;
    NextButton: TButton;
    BackButton: TButton;
    RepairRadioButton: TRadioButton;
    RemoveRadioButton: TRadioButton;
    DirectoryEdit: TEdit;
    BrowseButton: TButton;
    StartMenuCheckBox: TCheckBox;
    ShortcutCheckBox: TCheckBox;
    AllUsersCheckBox: TCheckBox;
    DirectoryOpenDialog: TOpenDialog;
    LocationLabel: TLabel;
    InstallProgressBar: TProgressBar;
    OperationListBox: TListBox;
    SuccessPanel: TPanel;
    FailurePanel: TPanel;
    WelcomePanel: TPanel;
    LicenseTabSheet: TTabSheet;
    AgreePanel: TPanel;
    AgreeSheckBox: TCheckBox;
    LicenseRichEdit: TRichEdit;
    procedure NextButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure BackButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  Private
    FCurrentPage : TAbstractInstallerPage;

    FInitialPage : TAbstractInstallerPage;
    FActionPage : TAbstractInstallerPage;
    FLicensePage : TAbstractInstallerPage;
    FSettingsPage : TAbstractInstallerPage;
    FProgressPage : TAbstractInstallerPage;
    FSuccessPage : TAbstractInstallerPage;
    FFailurePage : TAbstractInstallerPage;

    Procedure OnPageSelectedChanged(APage:TAbstractInstallerPage);
  end;

Var
  Form1: TForm1;

Implementation

{$R *.DFM}

Procedure TForm1.BackButtonClick(Sender: TObject);
begin
FCurrentPage.PreviousPressed;
end;

Procedure TForm1.CancelButtonClick(Sender: TObject);
begin
FCurrentPage.CancelPressed;
end;

Procedure TForm1.FormCreate(Sender: TObject);
begin
FInitialPage := TAbstractInstallerPage.Create(OnPageSelectedChanged, OnPageSelectedChanged, InitialTabSheet);
FActionPage := TAbstractInstallerPage.Create(OnPageSelectedChanged, OnPageSelectedChanged, ActionTabSheet);
FLicensePage := TAbstractInstallerPage.Create(OnPageSelectedChanged, OnPageSelectedChanged, LicenseTabSheet);
FSettingsPage := TAbstractInstallerPage.Create(OnPageSelectedChanged, OnPageSelectedChanged, SettingsTabSheet);
FProgressPage := TAbstractInstallerPage.Create(OnPageSelectedChanged, OnPageSelectedChanged, ProgressTabSheet);
FSuccessPage := TAbstractInstallerPage.Create(OnPageSelectedChanged, OnPageSelectedChanged, SuccessTabSheet);
FFailurePage := TAbstractInstallerPage.Create(OnPageSelectedChanged, OnPageSelectedChanged, FailureTabSheet);

FInitialPage.SetTargets(FActionPage, Nil, FFailurePage);
FActionPage.SetTargets(FLicensePage, FInitialPage, FFailurePage);
FLicensePage.SetTargets(FSettingsPage, FActionPage, FFailurePage);
FSettingsPage.SetTargets(FProgressPage, FLicensePage, FFailurePage);
FProgressPage.SetTargets(FSuccessPage, FSettingsPage, FFailurePage);

OnPageSelectedChanged(FCurrentPage);
end;

Procedure TForm1.FormDestroy(Sender: TObject);
begin
FFailurePage.Free;
FSuccessPage.Free;
FProgressPage.Free;
FSettingsPage.Free;
FLicensePage.Free;
FActionPage.Free;
FInitialPage.Free;
end;

Procedure TForm1.NextButtonClick(Sender: TObject);
begin
FCurrentPage.NextPressed;
end;

Procedure TForm1.OnPageSelectedChanged(APage:TAbstractInstallerPage);
begin
FCurrentPage := APage;
PagesPageControl.ActivePage := TTabSheet(FCurrentPage.Context);
CancelButton.Caption := APage.CancelButton.Caption;
CancelButton.Enabled := APage.CancelButton.Enabled;
BackButton.Caption := APage.PreviousButton.Caption;
BackButton.Enabled := APage.PreviousButton.Enabled;
NextButton.Caption := APage.NextButton.Caption;
NextButton.Enabled := APage.NextButton.Enabled;
end;

End.

