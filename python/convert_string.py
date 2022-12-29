def convert(string):
    st=""
    for i in range(0,len(string)):
        if string[i].islower() == True:
            st += string[i].upper()
        else:
            st += string[i].lower()
    return st
con="yes"
while(con != "No"):
    res=input("enter your string =")
    ans=convert(res)
    print(ans)
    con =input("Are you continue Yes/No = ")

    
        
