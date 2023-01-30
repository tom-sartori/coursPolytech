package com.company.part10.ex3;

import java.util.ArrayList;

class AssociationLaw1901{
    private String headOffice;
    private int creationYear;
    private Member president, secretary, treasurer;
    private ArrayList<Member> members = new ArrayList<>(),
            honoraryMembers = new ArrayList<>();

    public AssociationLaw1901(String headOffice, int creationYear) {
        this.headOffice = headOffice;
        this.creationYear = creationYear;
    }
    public void subscribeMember(Member m) { this.members.add(m); }
    public void subscribeHonorary(Member m) {
        this.honoraryMembers.add(m);
    }
    public String getHeadOffice() { return headOffice; }
    public void setHeadOffice(String headOffice) {
        this.headOffice = headOffice;
    }
    public int getCreationYear() { return creationYear; }
    public void setCreationYear(int reationYear) {
        this.creationYear = reationYear;
    }
    public Member getPresident() { return president; }
    public void setPresident(Member president) {
        this.president = president;
    }
    public Member getSecretary() { return secretary; }
    public void setSecretary(Member secretary) {
        this.secretary = secretary;
    }
    public Member getTreasurer() { return treasurer; }
    public void setTreasurer(Member treasurer) {
        this.treasurer = treasurer;
    }
    public ArrayList<Member> getMembers() { return members; }
    public void setMembers(ArrayList<Member> members) {
        this.members = members;
    }
    public ArrayList<Member> getHonoraryMembers() { return honoraryMembers; }
    public void setHonoraryMembers(ArrayList<Member> honoraryMembers) {
        this.honoraryMembers = honoraryMembers;
    }

    @Override
    public String toString() {
        return "AssociationLaw1901 [headOffice=" + headOffice + ", creationYear="
                + creationYear + ", president="+ president + ", secretary="
                + secretary + ", treasurer=" + treasurer + ", members="
                + members + ", honoraryMembers=" + honoraryMembers + "]";
    }
}
