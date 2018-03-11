Shader "Custom/Scroll" {
    Properties {
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
        _Color ("Tint", Color) = (1,1,1,1)

        _speedX ("Scroll Speed X", Float) = 0
        _speedY ("Scroll Speed Y", Float) = 0
    }

    SubShader{
        Tags { 
            "Queue"="Transparent" 
            "RenderType"="Transparent" 
        }

        Blend One OneMinusSrcAlpha

        Pass {
        CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag


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

            float4 _Color;
            float _speedX;
            float _speedY;
            sampler2D _MainTex;

            VertexOutput vert (VertexInput input) {
            	VertexOutput output;
            	output.v = UnityObjectToClipPos(input.pos);
            	output.uv = float2(input.uv.x + _speedX * _Time.y, input.uv.y + _speedY * _Time.y);
            	output.color = input.color * _Color;

            	return output;
            }

            float4 frag (VertexOutput output) : SV_Target {
            	float4 c = tex2D(_MainTex, output.uv) * output.color;
                c.rgb *= c.a;
                return c;
            }
        ENDCG
        }
    }
}