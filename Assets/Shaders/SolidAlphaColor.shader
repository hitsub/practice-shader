Shader "Custom/SolidAlphaColor" {
    SubShader {
    	Tags
        { 
            "Queue"="Transparent" 
            "RenderType"="Transparent" 
        }

        Blend One OneMinusSrcAlpha

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct VertexInput {
                float4 pos:  POSITION;    // 3D座標
                float4 color:	COLOR;	
            };

            struct VertexOutput {
                float4 v:    SV_POSITION; // 2D座標
                float4 color:	COLOR;	
            };

            VertexOutput vert(VertexInput input) {
            	VertexOutput output;
                output.v = UnityObjectToClipPos (input.pos);
            	output.color = input.color;

                return output;
            }

            float4 frag(VertexOutput output) : SV_Target {
            	float4 c = output.color;
            	c.rgb *= 0;
                return c;
            }
            ENDCG
        }
    }
}