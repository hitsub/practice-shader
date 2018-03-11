Shader "Custom/Sprite" {
    Properties {
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
        _Color ("Tint", Color) = (1,1,1,1)
    }

    SubShader{
        Tags { 
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "RenderType"="Transparent"
            "PreviewType"="Plane"
            "CanUseSpriteAtlas"="True"
        }

        Cull Off
		Lighting Off	
		ZWrite Off
       
        Blend One OneMinusSrcAlpha

        Pass {
        CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct VertexInput {
                float4 pos	:	POSITION;    // 3D座標
                float4 color:	COLOR;
                float2 uv	:	TEXCOORD0;   // テクスチャ座標
            };

            struct VertexOutput {
                float4 v	:	SV_POSITION; // 2D座標
                float4 color:	COLOR;	
                float2 uv	:   TEXCOORD0;   // テクスチャ座標
            };

            //プロパティの内容を受け取る
            float4 _Color;
            sampler2D _MainTex;
            sampler2D _AlphaTex;
            float _AlphaSplitEnabled;

            VertexOutput vert (VertexInput input) {
            	VertexOutput output;
            	output.v = UnityObjectToClipPos(input.pos);
            	output.uv = input.uv;

            	//テクスチャの色と設定した色を掛け合わせる
            	output.color = input.color * _Color; 

            	return output;
            }

            float4 frag (VertexOutput output) : SV_Target {
            	float4 c = tex2D(_MainTex, output.uv) * output.color;
            	#if UNITY_TEXTURE_ALPHASPLIT_ALLOWED
            		if (_AlphaSplitEnabled)
            			c.a = tex2D(_AlphaTex, output.uv).r;
            	#endif
                c.rgb *= c.a;
                return c;
            }
        ENDCG
        }
    }
}