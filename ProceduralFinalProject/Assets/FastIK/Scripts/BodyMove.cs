using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UIElements;

public class BodyMove : MonoBehaviour
{
    [SerializeField] private float speed = 10f;
    [SerializeField] private Rigidbody2D myRigidbody2D;
    private bool isMoving;
    private Animator myAnimator;
    [SerializeField] private GameObject currentTarget;
    [SerializeField] private GameObject[] legHeights;
    private float totalY;
    [SerializeField] private float bodyOffset = 10f;

    void Start()
    {
        myAnimator = GetComponent<Animator>();
    }
    
    void Update()
    {
        CheckHeight();
        transform.position = Vector2.MoveTowards(transform.position,
            new Vector2(currentTarget.transform.position.x, totalY),
            speed * Time.deltaTime);

        if (myRigidbody2D.velocity.sqrMagnitude > 0.1f)
        {
            isMoving = true;
            Debug.Log("true");
        }
        
        if (myRigidbody2D.velocity.sqrMagnitude == 0)
        {
            isMoving = false;
            Debug.Log("false");
        }
        //myAnimator.SetBool("isMoving", isMoving);
    }

    private void CheckHeight()
    {
        for (int i = 0; i < legHeights.Length; i++)
        {
            totalY = 0;
            totalY += legHeights[i].transform.position.y;
            totalY = totalY + bodyOffset;
            Debug.Log(totalY);
        }
    }
}
