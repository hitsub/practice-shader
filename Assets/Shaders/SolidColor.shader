Shader "Custom/SolidColor" {
    SubShader {
        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct VertexInput {
                float4 pos:  POSITION;    // 3D座標
            };

            struct VertexOutput {
                float4 v:    SV_POSITION; // 2D座標
            };

            VertexOutput vert(VertexInput input) {
            	VertexOutput output;
                output.v = UnityObjectToClipPos (input.pos);
                return output;
            }

            float4 frag() : SV_Target {
                return float4(1.0,0.0,0.0,1.0);
            }
            ENDCG
        }
    }
}