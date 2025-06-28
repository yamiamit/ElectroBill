#include <bits/stdc++.h>
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
using namespace std;
#ifndef ONLINE_JUDGE
#include "debugg.cpp"
#else
#define debug(...)
#define debugArr(...)
#endif
using namespace __gnu_pbds; 
#define ordered_set tree<int, null_type,less<int>, rb_tree_tag,tree_order_statistics_node_update> 
//change less<int> to less_equal<int> to make it a multiorderedset
//to erase from multiorderedset do s.erase(s.upperbound(a[i]))
//find_by_order(k)->iterator of the kth element
//order_of_key(k)->number of elements smaller than k
//ncr snip has modinv as well
#define float double
#define yes cout<<"YES"<<endl
#define no cout<<"NO"<<endl
#define endl '\n'
#define p(x) cout<<x<<endl
#define c(x) cout<<x<<" "
#define int long long
#define pb push_back
#define scanarr int a[n];for(int i=0;i<n;i++)cin>>a[i]
#define scannarr(a) int a[(int)(a)];for(int i=0;i<(int)(a);i++)cin>>a[i]
#define fr(i, a, b) for (int i = (a); i < (int)(b); ++i)
#define frr(i, a, b) for (int i = (a); i >= (int)(b); --i)
#define vi vector<int>
#define vvi vector<vector<int>>
#define pi pair<int,int>
#define vpi vector<pair<int,int>>
#define frr(i, a, b) for (int i = (a); i >= (int)(b); --i)
#define fast                          \
    ios_base::sync_with_stdio(false); \
    cin.tie(NULL)
#define sz(a) (int)(a.size())
#define all(a) a.begin(), a.end()
#define mod 1000000007

int gcd(int a, int b) {
    return b == 0 ? a : gcd(b, a % b);
}

void solve() {
    vector<int>v;
    for(int i=0;i<3;i++){int f;cin>>f;v.push_back(f);}
    int n=v.size();
    vector<int>a;
    for(int i=0;i<n;i++){
        if(i==0){a.push_back(v[i]);continue;}
        int nn=a.size();
        if(a[nn-1]<v[i]){a.push_back(v[i]);continue;}
        int k=lower_bound(v.begin(),v.end(),v[i])-v.begin();
        a[k]=v[i];
    }
    cout<<(a.size())<<endl;
    
}
signed main() {
    fast;
    int t=1;
    cin>>t;
    while (t--) {
        solve();
    }
    return 0;
}