import pandas as pd

yes = pd.read_csv('CU.csv')
f = open("output.txt", "w")
count = -1;
for row in yes:
    for column in yes:

        f.write("\t\t\t9\'d" + str(count) + ": begin //;\n")
        f.write("\t\t\tbegin\n")
        f.write("\t\t\t\tRF_ld <= " + str(yes[column][0]) + ";\n")
        f.write("\t\t\t\tIR_ld <= " + str(yes[column][1]) + ";\n")
        f.write("\t\t\t\tMAR_ld <= " + str(yes[column][2]) + ";\n")
        f.write("\t\t\t\tMDR_ld <= " + str(yes[column][3]) + ";\n")
        f.write("\t\t\t\tR_W <= " + str(yes[column][4]) + ";\n")
        f.write("\t\t\t\tMOV <= " + str(yes[column][5]) + ";\n")
        f.write("\t\t\t\tDT1 <= " + str(yes[column][6]) + ";\n")
        f.write("\t\t\t\tDT0 <= " + str(yes[column][7]) + ";\n")
        f.write("\t\t\t\tMA1 <= " + str(yes[column][8]) + ";\n")
        f.write("\t\t\t\tMA0 <= " + str(yes[column][9]) + ";\n")
        f.write("\t\t\t\tMB1 <= " + str(yes[column][10]) + ";\n")
        f.write("\t\t\t\tMB0 <= " + str(yes[column][11]) + ";\n")
        f.write("\t\t\t\tMC1 <= " + str(yes[column][12]) + ";\n")
        f.write("\t\t\t\tMC0 <= " + str(yes[column][13]) + ";\n")
        f.write("\t\t\t\tMD <= " + str(yes[column][14]) + ";\n")
        f.write("\t\t\t\tME <= " + str(yes[column][15]) + ";\n")
        f.write("\t\t\t\tOP4 <= " + str(yes[column][16]) + ";\n")
        f.write("\t\t\t\tOP3 <= " + str(yes[column][17]) + ";\n")
        f.write("\t\t\t\tOP2 <= " + str(yes[column][18]) + ";\n")
        f.write("\t\t\t\tOP1 <= " + str(yes[column][19]) + ";\n")
        f.write("\t\t\t\tOP0 <= " + str(yes[column][20]) + ";\n")
        f.write("\t\t\tend\n")
        count = count + 1
    
