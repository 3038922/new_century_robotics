# �����ͻ�������win10ϵͳ������������
Write-Host "�˰汾ʹ�������ͻ�����ѧԺ(�й�)��װԴ" -ForegroundColor Green
Write-Host "��ر���������360����Ѷ�ܼҵ��п�������ϵͳ�޸ĵİ�ȫ�������ֹϵͳ��װ����" -ForegroundColor Green
Write-Host "ȷ�Ϲرպ��밴���س���������..." -ForegroundColor Green
pause
Write-Host "��ʼ��װ" -ForegroundColor Green
$ncrRoboticsPath = "c:\ncrRobotics\"
$tmpPath = $ncrRoboticsPath + "temp\"
$winrar = "C:\Program Files\WinRAR\winrar.exe"

#visualstudio
if (Test-Path("C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC")) {
    Write-Host "vs2019 �Ѱ�װ" -ForegroundColor Green
}
else {
    # ����vsѹ����
    $vsRar = $tmpPath + "vs2019.rar"
    $client = new-object System.Net.WebClient #�������ض���
    if (Test-Path($vsRar)) {
        Write-Host "$vsRar �Ѵ���������������" -ForegroundColor Green
    }
    else {
        Write-Host "��ʼ���� vs2019.rar" -ForegroundColor Green
        $client.DownloadFile('https://qzrobot.top/index.php/s/TRZwkD9dJNxZoWk/download/vs2019.rar', $tmpPath + 'vs2019.rar')
        Start-Sleep -Milliseconds 200  # �ӳ�0.2��
    }
    # ��ѹ��
    $vs = $tmpPath + "vs2019"
    if (Test-Path($vs)) {
        Write-Host "$vs �Ѵ��������ѹ" -ForegroundColor Green
    }
    else {
        Write-Host "��ʼ��ѹ�� vs2019.rar" -ForegroundColor Green
        $iArgs = "x -ibck -y " + $tmpPath + "vs2019.rar" + " $tmpPath"
        Start-Process  $winrar $iArgs -Wait #��ѹ��zip
    }

}
Write-Host "���ڰ�װ vs2019" -ForegroundColor Green
Start-Process ("C:\ncrRobotics\temp\vs2019\vs_Community.exe") " --noweb --add Microsoft.VisualStudio.Workload.NativeDesktop --add Microsoft.VisualStudio.Workload.NativeCrossPlat --add Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset --add Microsoft.VisualStudio.Component.VC.Llvm.Clang --includeRecommended" -Wait
Write-Host "��װ��� vs2019" -ForegroundColor Green
Write-Host "��װ��� vs2019" -ForegroundColor Yellow
Write-Host "��װ��� vs2019" -ForegroundColor Red