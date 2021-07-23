Shader "CutoutBoxShader"
{
    Properties
    {
    }
    SubShader
    {
        Pass
        {
            ZTest Greater // This causes the sides of the box to only draw if it is *behind* another object. When combined with the CutoutSphereShader, the box will only draw if it is inside the sphere
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float3 objSpace : TEXCOORD1;
                float4 vertex : SV_POSITION;
            };
            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.objSpace = v.vertex + .5;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
              return lerp(float4(0, .5, .5, 1), float4(1, .75, .5, 1), i.objSpace.y); // Picking some random colors to makee it look pretty
              return float4(i.objSpace.yyy, 1);
            }
            ENDCG
        }
    }
}
