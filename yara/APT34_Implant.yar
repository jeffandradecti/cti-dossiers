rule APT34_Implant_String_Deobfuscation{
  meta:
    description = "Detects behavior related to APT34 activity, namely the Mango and Solar backdoor implants, alongside its droppers."
    author = "Jefferson Andrade"
    date = "2026-01-27"
    reference = "ESET Research – OilRig: Outer Space / Juicy Mix"


  strings:
    //Mango Dropper

    //VBS dropper routine to decode the backdoor, encoded in base64
    $dropper_string1 = /fn\s*=\s*fn\s*\+\s*Chr\(\d{1,3}[+-]\d{1,3}\)/ nocase
    //VBS dropper string deobfuscation routine
    $dropper_string2 = /Replace\(\w+\s*,\s*Chr\(\d{1,3}\)\s*,\s*Chr\(\d{1,3}\)\)/ nocase

    //Solar Backdoor

    //.NET string deobfuscation routine
    $solar_string1 = /\w+\s*\[\s*\w+\s*\]\s*=\s*\(byte\)\s*\(\s*\w+\s*\[\s*\w+\s*\]\s*\^\s*\w+\s*\[\s*\w+\s*%\s*\w+\.Length\s*\]\s*\)/ nocase


    //Mango Backdoor

    //.NET string deobfuscation routine, detects at least three repetitions of the .ToString() function
    $mango_string1 = /('\w'\.ToString\(\)\s*){3}/ nocase
  
  
  condition:
    2 of ($dropper_*) or
    $solar_string1 or
    $mango_string1

}