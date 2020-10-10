using System;
using System.Collections;
using System.Collections.Generic;
using DG.Tweening;
using UnityEngine;

public class Leg : MonoBehaviour
{
    [SerializeField] private float speed = 3f;
    [SerializeField] private Transform currentTarget;
    [SerializeField] private GameObject foot;
    [SerializeField] private GameObject desiredTarget;
    private float targetDist;
    private float upMidDist;
    private float midLowDist;
    private float fullLegDist;
    private float legStretchDist;
    private float timer;
    [SerializeField] private float moveSpeed = 0.1f;
    [SerializeField] private float jumpPower = 0.1f;
    [SerializeField] private float buffer = 1.5f; 
    [SerializeField] private AnimationCurve yCurve;
    [SerializeField] private float distToStep = 10; 
    [SerializeField] private Transform upLegJoint;
    [SerializeField] private Transform midLegJoint;
    [SerializeField] private Transform lowLegJoint;

    private void Start()
    {
        currentTarget = foot.transform;
        upMidDist = Vector2.Distance(upLegJoint.position, midLegJoint.position);
        midLowDist = Vector2.Distance(midLegJoint.position, lowLegJoint.position);
        fullLegDist = upMidDist + midLowDist;
    }

    void Update()
    {
        targetDist = Vector2.Distance(currentTarget.position, desiredTarget.transform.position);
        legStretchDist = Vector2.Distance(currentTarget.position, desiredTarget.transform.position);

        foot.transform.position = Vector2.MoveTowards(foot.transform.position,
            currentTarget.position, speed * Time.deltaTime);

        if (targetDist > distToStep | legStretchDist >= fullLegDist - buffer)
        {
            currentTarget.DOJump(desiredTarget.transform.position, jumpPower, 1, moveSpeed);
        }
    }
}
