namespace RoomBuildingStarterKit.Components
{
    using UnityEngine;

    public class DoorController : MonoBehaviour
    {
        private Animator animator;

        private int NPCCount = 0;

        private void Awake()
        {
            this.animator = this.GetComponent<Animator>();
        }

        /// <summary>
        /// Triggers when other collider enter door collider.
        /// </summary>
        /// <param name="collider">Other collider.</param>
        private void OnTriggerEnter(Collider collider)
        {
            if (collider.gameObject.layer == LayerMask.NameToLayer("NPC"))
            {
                ++this.NPCCount;
                this.animator.SetBool("Open", true);
            }
        }

        /// <summary>
        /// Triggers when other collider exit door collider.
        /// </summary>
        /// <param name="collider">Other collider.</param>
        private void OnTriggerExit(Collider collider)
        {
            if (collider.gameObject.layer == LayerMask.NameToLayer("NPC"))
            {
                --this.NPCCount;
                if (this.NPCCount <= 0)
                {
                    this.NPCCount = 0;
                    this.animator.SetBool("Open", false);
                }
            }
        }
    }
}