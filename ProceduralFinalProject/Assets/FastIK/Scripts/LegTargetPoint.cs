using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LegTargetPoint : MonoBehaviour
{
    float desiredYPosition;
    private Transform desiredTarget;

    void Update()
    {
        RaycastHit2D hit = Physics2D.Raycast(new             
                Vector2(transform.position.x, transform.position.y + 5),               
            -Vector2.up, 12f);

        // If we hit a collider, set the desiredYPosition to the hit Y point.        
        if (hit.collider != null)
        {
            transform.position = hit.point;
        }
        else
        {
            desiredYPosition = transform.position.y;
        }

        //desiredTarget.position = new Vector2(desiredTarget.position.x,     
            //desiredYPosition);
    }
}
